# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Secure Cinema is a full-stack cinema ticket booking application built with Java microservices and React frontend. The application follows a microservice architecture with the following components:

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

## Logging and Monitoring

The application uses centralized logging with the following components:
- **Logback**: Configured via `logback-spring.xml` files in each service
- **Console Appender**: Colored logs for development
- **Rolling File Appender**: Log files stored in `./logs` directory
- **Distributed Tracing**: TraceID and SpanID visible in logs
- **API Gateway Logging**: Centralized request/response logging in the API Gateway via `LoggingFilter`
- **Log Levels**: INFO for most operations, DEBUG for Gateway routes, TRACE for application-specific details

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
- Bean Validation (JSR-380) for input validation
- PostgreSQL, MongoDB, Redis
- Apache Kafka
- WebClient (WebFlux)
- Resilience4j (Circuit Breaker)
- Zipkin and Sleuth (distributed tracing)
- Logback for centralized logging

### Frontend
- React
- Redux
- Bootstrap
- Axios
- HTML5 form validation

## Authentication and Users

### Default Test Users
- Admin User: 
  - Email: admin@securecinema.com
  - Password: adminpass
- Regular User: 
  - Email: john.smith@example.com
  - Password: password123
- Customer User:
  - Email: customer@securecinema.com
  - Password: password123

### Phone Number Format
The application validates South African phone numbers in the format: `0XX XXX XXXX`

## Input Validation

### Backend Validation
The application implements backend validation using Bean Validation (JSR-380):

1. **UserService DTO Validation**:
   - `UserRegisterRequestDto`: Validates name length, email format, phone number pattern, and password requirements
   - `UserLoginRequestDto`: Ensures email format and password presence

2. **MovieService DTO Validation**:
   - `CommentRequestDto`: Validates required fields and comment text length
   - `MovieRequestDto`: Validates movie details including name, description length, and required relationships

3. **Validation Error Handling**:
   - Custom `ValidationExceptionHandler` returns field-specific validation errors
   - Returns HTTP 400 Bad Request responses with detailed error messages

### Frontend Validation
The application implements client-side validation:

1. **HTML5 Validation Attributes**:
   - Required fields: Prevents form submission with empty required fields
   - Pattern validation: Validates phone numbers using regex pattern
   - Type validation: Uses input type="email" for email validation

2. **Form Submission Validation**:
   - Password matching validation in registration form
   - Client-side data validation before API requests

## Database Seeding

### PostgreSQL (Movie Service)
The database is seeded with initial data through `data.sql` in `movieService/src/main/resources/`.

Important tables:
- movie - Movies with details and foreign keys to category and director
- actor - Movie cast with foreign key to movie
- city - Cities where movies are shown (Johannesburg, Cape Town, etc.)
- movie_image - Movie poster images with URLs
- category - Movie genres
- director - Movie directors

### MongoDB (User Service)
The user database is seeded with:
- User collection: Admin and regular user accounts
- Claim collection: ADMIN and USER roles

## Core User Flows

1. **Authentication** - Login/register through modals
2. **Movie Browsing** - View films on main page
3. **Movie Details** - View film info, cast, comments
4. **Ticket Booking** - Select city, showtime, seats
5. **Payment** - Enter card details and confirm
6. **Admin Functions** - Add/edit movies, actors, and showtimes

## Key Files and Components

### Frontend Components
- **src/layout/** - Contains layout components (Navbar, Footer, etc.)
- **src/pages/** - Contains main page components
  - **MainPage.jsx** - Home page showing movies
  - **DetailPage.jsx** - Movie details and booking page
  - **BuyTicketPage.jsx** - Ticket selection and payment page
  - **LoginModal.jsx/RegisterModal.jsx** - Authentication modals
- **src/services/** - API service calls to backend
- **src/store/** - Redux state management
- **src/utils/** - Utility functions and custom components

### Backend Services
- **movieService/src/main/java/com/kaankaplan/movieService/**
  - **business/** - Service implementations
  - **controller/** - REST endpoints
  - **entity/** - Data models
  - **dao/** - Data access objects
- **userService/src/main/java/com/kaankaplan/userService/**
  - Core authentication and user management
- **emailService/src/main/java/com/kaankaplan/emailService/**
  - Email sending functionality using Kafka

## Email Templates
- **emailService/src/main/resources/templates/emailTemplate.ftlh** - FreeMarker template for ticket confirmation emails

## UI Theme

The application uses a dark theme with purple accents:
- Dark background: #121212
- Primary accent: #BB86FC
- Secondary accent: #6200EE
- Success color: #03DAC5

## Text Colors and Styling
- All user-facing text should be in English
- Main content text should be black for readability
- Text over dark backgrounds should be white
- Movie time buttons should use light colors for better contrast against dark backgrounds

## Localization and Internationalization

The application has been internationalized from Turkish to English. Key files involved:

### Frontend
- **src/utils/dateConvertForTicket.js** - Date formatting using toLocaleDateString with "en-US" locale
- **src/pages/DetailPage.jsx** - Movie details page with comments section
- **src/pages/BuyTicketPage.jsx** - Ticket selection and payment page

### Backend
- **emailService/src/main/resources/templates/emailTemplate.ftlh** - Email template
- **movieService/src/main/java/com/kaankaplan/movieService/business/concretes/PaymentServiceImpl.java** - Email subject

### Key Points for Translation
- All UI elements should display English text
- Email templates should use English
- Date formats should follow English conventions
- Database records can retain original language content