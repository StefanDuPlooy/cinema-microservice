package com.kaankaplan.userService.config;

import com.kaankaplan.userService.entity.Claim;
import com.kaankaplan.userService.entity.User;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class MongoDbSeedConfig {

    private final BCryptPasswordEncoder passwordEncoder;

    public MongoDbSeedConfig(BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    CommandLineRunner commandLineRunner(MongoTemplate mongoTemplate) {
        return args -> {
            // Clear existing collections
            mongoTemplate.remove(new Query(), "user");
            mongoTemplate.remove(new Query(), "claim");

            // Create and save Claims
            Claim adminClaim = Claim.builder()
                    .claimName("ADMIN")
                    .build();
            
            Claim userClaim = Claim.builder()
                    .claimName("USER")
                    .build();
            
            Claim customerClaim = Claim.builder()
                    .claimName("CUSTOMER")
                    .build();
            
            mongoTemplate.save(adminClaim);
            mongoTemplate.save(userClaim);
            mongoTemplate.save(customerClaim);
            
            // Create and save Users
            String defaultPassword = passwordEncoder.encode("password123");
            String adminPassword = passwordEncoder.encode("adminpass");
            
            User adminUser = User.builder()
                    .email("admin@securecinema.com")
                    .password(adminPassword)
                    .fullName("Admin User")
                    .claim(adminClaim)
                    .build();
            
            User user1 = User.builder()
                    .email("john.smith@example.com")
                    .password(defaultPassword)
                    .fullName("John Smith")
                    .claim(userClaim)
                    .build();
            
            User user2 = User.builder()
                    .email("sarah.johnson@example.com")
                    .password(defaultPassword)
                    .fullName("Sarah Johnson")
                    .claim(userClaim)
                    .build();
            
            User user3 = User.builder()
                    .email("michael.brown@example.com")
                    .password(defaultPassword)
                    .fullName("Michael Brown")
                    .claim(userClaim)
                    .build();
            
            User user4 = User.builder()
                    .email("emma.davis@example.com")
                    .password(defaultPassword)
                    .fullName("Emma Davis")
                    .claim(userClaim)
                    .build();
            
            User user5 = User.builder()
                    .email("david.wilson@example.com")
                    .password(defaultPassword)
                    .fullName("David Wilson")
                    .claim(userClaim)
                    .build();
            
            User user6 = User.builder()
                    .email("jennifer.moore@example.com")
                    .password(defaultPassword)
                    .fullName("Jennifer Moore")
                    .claim(userClaim)
                    .build();
            
            User user7 = User.builder()
                    .email("robert.taylor@example.com")
                    .password(defaultPassword)
                    .fullName("Robert Taylor")
                    .claim(userClaim)
                    .build();
            
            User user8 = User.builder()
                    .email("amanda.martinez@example.com")
                    .password(defaultPassword)
                    .fullName("Amanda Martinez")
                    .claim(userClaim)
                    .build();
                    
            User customerUser = User.builder()
                    .email("customer@securecinema.com")
                    .password(defaultPassword)
                    .fullName("Customer User")
                    .claim(customerClaim)
                    .build();
            
            // Save all users
            mongoTemplate.save(adminUser);
            mongoTemplate.save(user1);
            mongoTemplate.save(user2);
            mongoTemplate.save(user3);
            mongoTemplate.save(user4);
            mongoTemplate.save(user5);
            mongoTemplate.save(user6);
            mongoTemplate.save(user7);
            mongoTemplate.save(user8);
            mongoTemplate.save(customerUser);
            
            System.out.println("MongoDB seeding completed!");
            System.out.println("Added 3 claims");
            System.out.println("Added 10 users");
        };
    }
}