package com.kaankaplan.userService.business.concretes;

import com.kaankaplan.userService.business.abstracts.AuthService;
import com.kaankaplan.userService.business.abstracts.UserService;
import com.kaankaplan.userService.core.security.JwtProviderService;
import com.kaankaplan.userService.entity.User;
import com.kaankaplan.userService.entity.dto.UserAuthenticationResponseDto;
import com.kaankaplan.userService.entity.dto.UserLoginRequestDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private static final Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);
    private final AuthenticationManager authenticationManager;
    private final JwtProviderService jwtProvider;
    private final UserService userService;

    @Override
    public UserAuthenticationResponseDto login(UserLoginRequestDto userLoginRequestDto) {
        logger.debug("Processing login request for email: {}", userLoginRequestDto.getEmail());
        
        try {
            Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                    userLoginRequestDto.getEmail(),
                    userLoginRequestDto.getPassword()
            ));

            logger.debug("Authentication successful for user: {}", userLoginRequestDto.getEmail());
            SecurityContextHolder.getContext().setAuthentication(authenticate);
            
            logger.debug("Generating JWT token for user: {}", userLoginRequestDto.getEmail());
            String token = jwtProvider.generateToken(authenticate);

            logger.debug("Retrieving user details for: {}", userLoginRequestDto.getEmail());
            User user = userService.getUserByEmail(userLoginRequestDto.getEmail());

            logger.debug("Building authentication response for user: {}", userLoginRequestDto.getEmail());
            return UserAuthenticationResponseDto.builder()
                    .userId(user.getUserId())
                    .fullName(user.getFullName())
                    .email(userLoginRequestDto.getEmail())
                    .token(token)
                    .roles(authenticate.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()))
                    .build();
        } catch (Exception e) {
            logger.error("Authentication process failed for user: {}, error: {}", userLoginRequestDto.getEmail(), e.getMessage());
            throw e;
        }
    }

}
