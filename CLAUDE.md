# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CineVision is a full-stack cinema ticket booking application built with Java microservices and React frontend. The application follows a microservice architecture with the following components:

- **API Gateway**: Routes incoming requests using Spring Cloud Gateway
- **Eureka Server**: Provides service discovery and registration
- **User Service**: Handles user management with MongoDB and JWT authentication
- **Movie Service**: Manages movies, actors, directors with PostgreSQL
- **Email Service**: Sends email notifications using Apache Kafka and Java Mail Sender

## Build and Run Commands

### Prerequisites
- Java 17
- Node.js and npm
- Docker and Docker Compose

### Infrastructure Setup
Start all required infrastructure services:
```
docker-compose up -d
```

### Building Microservices
Build all services:
```
mvn clean install
```

Build specific service:
```
mvn clean install -f <service-name>/pom.xml
```

### Running Microservices
Start services in the following order:

1. Eureka Server:
```
mvn spring-boot:run -f eureka-server/pom.xml
```

2. User Service:
```
mvn spring-boot:run -f userService/pom.xml
```

3. Movie Service:
```
mvn spring-boot:run -f movieService/pom.xml
```

4. Email Service:
```
mvn spring-boot:run -f emailService/pom.xml
```

5. API Gateway:
```
mvn spring-boot:run -f api-gateway/pom.xml
```

### Frontend
Install dependencies:
```
cd frontend
npm install
```

Start development server:
```
npm start
```

Build for production:
```
npm run build
```

## Testing

### Backend Testing
Run all tests:
```
mvn test
```

Run tests for specific service:
```
mvn test -f <service-name>/pom.xml
```

### Frontend Testing
```
cd frontend
npm test
```

## Service Communication

The microservices communicate through:
- **Synchronous**: REST API calls via WebClient
- **Asynchronous**: Event-driven messaging with Apache Kafka

## Important Configuration

- Eureka Server: http://localhost:8761 (username: eureka, password: password)
- Frontend: http://localhost:3000
- PostgreSQL: localhost:5432 (user: postgres, password: 12345)
- MongoDB: localhost:27017 (user: rootuser, password: rootpass)
- Mongo Express UI: http://localhost:8091
- Zipkin Tracing: http://localhost:9411

Before running the Email Service, update the email configuration in `emailService/src/main/resources/application.yml` with valid credentials.

## Technical Stack

### Backend
- Java 17
- Spring Boot 2.7.0
- Spring Cloud (Eureka, Gateway)
- Spring Security with JWT
- PostgreSQL, MongoDB, Redis
- Apache Kafka
- WebClient (WebFlux)
- Resilience4j (Circuit Breaker)
- Zipkin and Sleuth (distributed tracing)

### Frontend
- React
- Redux
- Bootstrap
- Axios