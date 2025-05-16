package com.kaankaplan.apigateway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.server.ResponseStatusException;

@Configuration
@EnableWebFluxSecurity
public class SecurityConfig {

    @Bean
    public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity serverHttpSecurity){

        serverHttpSecurity.cors().and().csrf().disable()
                .authorizeExchange(exchange -> exchange
                        .anyExchange()
                        .permitAll())
                .exceptionHandling()
                .accessDeniedHandler((exchange, denied) -> {
                    return exchange.getPrincipal()
                            .doOnNext(principal -> {
                                throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Access Denied");
                            })
                            .flatMap(principal -> exchange.getPrincipal());
                })
                .authenticationEntryPoint((exchange, ex) -> {
                    throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required");
                });
                
        return serverHttpSecurity.build();
    }
}
