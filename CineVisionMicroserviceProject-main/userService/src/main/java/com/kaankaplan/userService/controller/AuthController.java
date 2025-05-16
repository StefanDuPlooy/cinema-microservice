package com.kaankaplan.userService.controller;

import com.kaankaplan.userService.business.abstracts.AuthService;
import com.kaankaplan.userService.entity.dto.UserAuthenticationResponseDto;
import com.kaankaplan.userService.entity.dto.UserLoginRequestDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/user/auth")
@RequiredArgsConstructor
public class AuthController {

    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
    private final AuthService authService;

    @PostMapping("/login")
    public UserAuthenticationResponseDto login(@Valid @RequestBody UserLoginRequestDto userLoginRequestDto) {
        logger.info("Login attempt for email: {}", userLoginRequestDto.getEmail());
        try {
            UserAuthenticationResponseDto response = authService.login(userLoginRequestDto);
            logger.info("Successful login for user: {}", userLoginRequestDto.getEmail());
            return response;
        } catch (Exception e) {
            logger.error("Login failed for user: {}, reason: {}", userLoginRequestDto.getEmail(), e.getMessage());
            throw e;
        }
    }
}
