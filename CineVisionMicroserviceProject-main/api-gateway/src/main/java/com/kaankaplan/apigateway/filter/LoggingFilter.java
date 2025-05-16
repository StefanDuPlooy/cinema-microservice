package com.kaankaplan.apigateway.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.cloud.gateway.route.Route;
import org.springframework.cloud.sleuth.CurrentTraceContext;
import org.springframework.cloud.sleuth.Tracer;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.util.Collections;
import java.util.Set;

import static org.springframework.cloud.gateway.support.ServerWebExchangeUtils.GATEWAY_ORIGINAL_REQUEST_URL_ATTR;
import static org.springframework.cloud.gateway.support.ServerWebExchangeUtils.GATEWAY_REQUEST_URL_ATTR;
import static org.springframework.cloud.gateway.support.ServerWebExchangeUtils.GATEWAY_ROUTE_ATTR;

@Component
public class LoggingFilter implements GlobalFilter {

    private static final Logger logger = LoggerFactory.getLogger(LoggingFilter.class);
    private final Tracer tracer;

    public LoggingFilter(Tracer tracer) {
        this.tracer = tracer;
    }

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        Set<URI> originalUris = exchange.getAttributeOrDefault(GATEWAY_ORIGINAL_REQUEST_URL_ATTR, Collections.emptySet());
        
        if (originalUris.isEmpty()) {
            return chain.filter(exchange);
        }
        
        Route route = exchange.getAttribute(GATEWAY_ROUTE_ATTR);
        URI requestUrl = exchange.getAttribute(GATEWAY_REQUEST_URL_ATTR);
        ServerHttpRequest request = exchange.getRequest();
        
        // Safe retrieval of trace and span IDs with null checks
        final String traceId;
        final String spanId;
        
        if (tracer.currentSpan() != null) {
            traceId = tracer.currentSpan().context().traceId();
            spanId = tracer.currentSpan().context().spanId();
        } else {
            traceId = "unknown";
            spanId = "unknown";
        }
        
        logger.info(
            "Request: [TraceID: {}, SpanID: {}] {} {} route: {}, to URI: {}, Headers: {}",
            traceId,
            spanId,
            request.getMethod(),
            request.getPath(),
            route != null ? route.getId() : "Unknown",
            requestUrl,
            request.getHeaders()
        );
        
        final long startTime = System.currentTimeMillis();
        
        return chain.filter(exchange).then(Mono.fromRunnable(() -> {
            long duration = System.currentTimeMillis() - startTime;
            logger.info(
                "Response: [TraceID: {}, SpanID: {}] completed with status: {}, in: {}ms",
                traceId,
                spanId,
                exchange.getResponse().getStatusCode(),
                duration
            );
        }));
    }
}