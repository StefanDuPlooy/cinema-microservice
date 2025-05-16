package com.kaankaplan.apigateway.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Component
public class RateLimiterFilter implements GlobalFilter, Ordered {
    private static final Logger logger = LoggerFactory.getLogger(RateLimiterFilter.class);

    // Simple in-memory rate limiter as a fallback if Redis is not available
    private final Map<String, RequestCounter> requestCounters = new ConcurrentHashMap<>();
    private static final int MAX_REQUESTS_PER_MINUTE = 300; // Increased default rate limit for development
    private static final long ONE_MINUTE_IN_MILLIS = 60 * 1000;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        String path = exchange.getRequest().getPath().toString();
        
        // Skip rate limiting for normal application flows and static resources
        boolean shouldSkipRateLimiting = 
            path.startsWith("/api/movie") || 
            path.startsWith("/api/user/auth") ||
            path.startsWith("/eureka");
            
        if (shouldSkipRateLimiting) {
            return chain.filter(exchange);
        }
        
        String clientIp = exchange.getRequest().getRemoteAddress().getHostName();
        
        // Get or create request counter for this IP
        RequestCounter counter = requestCounters.computeIfAbsent(clientIp, 
            k -> new RequestCounter(System.currentTimeMillis()));
        
        // Check if we need to reset the counter (time window expired)
        if (System.currentTimeMillis() - counter.getStartTime() > ONE_MINUTE_IN_MILLIS) {
            counter.reset(System.currentTimeMillis());
        }
        
        // Increment the counter and check if rate limit is exceeded
        int requestCount = counter.incrementAndGet();
        
        // Only apply rate limiting if a suspicious number of requests is detected
        if (requestCount > MAX_REQUESTS_PER_MINUTE) {
            logger.warn("Rate limit exceeded for client IP: {}, request count: {}, path: {}", 
                clientIp, requestCount, path);
            exchange.getResponse().setStatusCode(HttpStatus.TOO_MANY_REQUESTS);
            exchange.getResponse().getHeaders().add("X-Rate-Limit-Exceeded", "true");
            exchange.getResponse().getHeaders().add("Retry-After", "60");
            return exchange.getResponse().setComplete();
        }
        
        // Add headers to show rate limit information
        exchange.getResponse().getHeaders().add("X-Rate-Limit", String.valueOf(MAX_REQUESTS_PER_MINUTE));
        exchange.getResponse().getHeaders().add("X-Rate-Limit-Remaining", 
            String.valueOf(MAX_REQUESTS_PER_MINUTE - requestCount));
            
        return chain.filter(exchange);
    }
    
    @Override
    public int getOrder() {
        // Execute this filter before the main rate limiter to provide a fallback
        return -1;
    }
    
    // Inner class to track request counts within a time window
    private static class RequestCounter {
        private final AtomicInteger count = new AtomicInteger(0);
        private long startTime;
        
        public RequestCounter(long startTimeMillis) {
            this.startTime = startTimeMillis;
        }
        
        public int incrementAndGet() {
            return count.incrementAndGet();
        }
        
        public long getStartTime() {
            return startTime;
        }
        
        public void reset(long newStartTime) {
            count.set(0);
            startTime = newStartTime;
        }
    }
}