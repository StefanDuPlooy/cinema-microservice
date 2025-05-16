package com.kaankaplan.apigateway.exception;

import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.cloud.gateway.support.NotFoundException;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;

@Component
@Order(-2) // High precedence to catch exceptions early
public class RateLimitExceededHandler implements ErrorWebExceptionHandler {

    @Override
    public Mono<Void> handle(ServerWebExchange exchange, Throwable ex) {
        ServerHttpResponse response = exchange.getResponse();
        
        HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
        String message = "Unknown error";
        
        if (ex instanceof ResponseStatusException) {
            status = ((ResponseStatusException) ex).getStatus();
            message = ex.getMessage();
        } else if (ex instanceof NotFoundException) {
            status = HttpStatus.NOT_FOUND;
            message = "Resource not found";
        } else if (ex.getMessage() != null && ex.getMessage().contains("Too many requests")) {
            status = HttpStatus.TOO_MANY_REQUESTS;
            message = "Rate limit exceeded. Please try again later.";
        }
        
        final HttpStatus responseStatus = status;
        final String responseMessage = message;
        
        response.setStatusCode(responseStatus);
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        
        return response.writeWith(Mono.fromSupplier(() -> {
            DataBufferFactory bufferFactory = response.bufferFactory();
            String errorJson = String.format("{\"status\":%d,\"error\":\"%s\",\"message\":\"%s\"}",
                    responseStatus.value(), responseStatus.getReasonPhrase(), responseMessage);
            return bufferFactory.wrap(errorJson.getBytes(StandardCharsets.UTF_8));
        }));
    }
}