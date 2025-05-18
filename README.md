# Secure Cinema - Microservice Cinema Ticket Booking System

A full-stack cinema ticket booking application built with Java microservices and React frontend, featuring a robust security model, distributed architecture, and modern user experience.

## Project Overview

Secure Cinema is a comprehensive platform for online cinema ticket sales, allowing users to:

- Browse current and upcoming movies
- View detailed movie information (plot, actors, ratings)
- Purchase tickets with location and seat selection
- Make secure online payments
- Receive email confirmations
- Share opinions through movie comments

The application follows a microservice architecture with the following components:

- **API Gateway**: Routes incoming requests using Spring Cloud Gateway
- **Eureka Server**: Provides service discovery and registration
- **User Service**: Handles user management with MongoDB and JWT authentication
- **Movie Service**: Manages movies, actors, directors with PostgreSQL
- **Email Service**: Sends email notifications using Apache Kafka and Java Mail Sender

## Features

- **Secure Authentication**: JWT-based user authentication with role-based access control
- **Smart Rate Limiting**: Protection against DDoS attacks with configurable rate limits
- **Responsive UI**: Mobile-friendly interface with dark theme and modern design
- **Distributed Tracing**: Request tracking across services with Zipkin and Sleuth
- **Circuit Breaker Pattern**: Resilience4j integration for graceful failure handling
- **Input Validation**: Both frontend and backend validation for data integrity
- **Cache Management**: Redis caching for improved performance
- **Centralized Logging**: Comprehensive logging with distributed trace IDs

## Technology Stack

### Backend

- Java 17
- Spring Boot 2.7.0
- Spring Cloud (Eureka, Gateway)
- Spring Security with JWT
- Bean Validation (JSR-380)
- PostgreSQL, MongoDB, Redis
- Apache Kafka
- WebClient (WebFlux)
- Resilience4j
- Zipkin and Sleuth
- Logback

### Frontend

- React
- Redux
- Bootstrap
- Axios
- HTML5 form validation

### Infrastructure

- Docker & Docker Compose
- Maven

## Prerequisites

Before running the application, ensure you have:

- Java 17
- Node.js and npm
- Docker and Docker Compose

## Getting Started

### Infrastructure Setup

Start all required infrastructure services:

```bash
docker-compose up -d
```

This will start:

- PostgreSQL (Movie Service database)
- MongoDB (User Service database)
- Apache Kafka (Asynchronous messaging)
- Zipkin (Distributed tracing)
- MongoDB Express (Database UI)

### Building Microservices

Build all services:

```bash
mvn clean install
```

Or build a specific service:

```bash
mvn clean install -f <service-name>/pom.xml
```

### Running Microservices

Start services in the following order:

1. **Eureka Server**:

```bash
mvn spring-boot:run -f eureka-server/pom.xml
```

2. **User Service**:

```bash
mvn spring-boot:run -f userService/pom.xml
```

3. **Movie Service**:

```bash
mvn spring-boot:run -f movieService/pom.xml
```

4. **Email Service**:
   > **Important**: Before running, update email configurations in `emailService/src/main/resources/application.yml`.

```bash
mvn spring-boot:run -f emailService/pom.xml
```

5. **API Gateway**:

```bash
mvn spring-boot:run -f api-gateway/pom.xml
```

### Frontend Application

Install dependencies:

```bash
cd frontend
npm install
```

Start development server:

```bash
npm start
```

Build for production:

```bash
npm run build
```

## Testing

### Backend Testing

Run all tests:

```bash
mvn test
```

Run tests for specific service:

```bash
mvn test -f <service-name>/pom.xml
```

### Frontend Testing

```bash
cd frontend
npm test
```

## Service URLs

- **Frontend**: http://localhost:3000
- **Eureka Server**: http://localhost:8761 (username: eureka, password: password)
- **MongoDB Express UI**: http://localhost:8091
- **Zipkin Tracing**: http://localhost:9411

## Default Test Users

- **Admin User**:

  - Email: admin@securecinema.com
  - Password: adminpass

- **Regular User**:

  - Email: john.smith@example.com
  - Password: password123

- **Customer User**:
  - Email: customer@securecinema.com
  - Password: password123

## Core User Flows

1. **Authentication** - Login/register through modals
2. **Movie Browsing** - View films on main page
3. **Movie Details** - View film info, cast, comments
4. **Ticket Booking** - Select city, showtime, seats
5. **Payment** - Enter card details and confirm
6. **Admin Functions** - Add/edit movies, actors, and showtimes

## Security Features

### JWT Authentication

The application implements a robust JWT-based authentication system:

- Token generation using HMAC-SHA algorithm
- User roles stored as JWT claims
- Stateless session management
- Request filtering with proper authorization extraction

### Rate Limiting

The API Gateway includes rate limiting to protect against DDoS attacks:

- Smart rate limiting for suspicious traffic patterns
- Normal application paths excluded from rate limiting
- Default limit of 300 requests per minute per IP
- Rate limit headers for client feedback

## Database Model

### PostgreSQL (Movie Service)

- Movies with details and relationships
- Actors and directors
- Cities and theaters
- Showtimes and ticket information
- Categories (genres)

### MongoDB (User Service)

- User accounts with credentials and profile data
- Role-based permissions (ADMIN and USER roles)

### References
Helped set up initial base micro service: https://github.com/VonHumbolt/CineVisionMicroserviceProject.git
</details>

## License

This project is licensed under the MIT License - see the LICENSE file for details.
