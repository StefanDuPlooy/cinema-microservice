# Api Gateway
Api gateway manages incoming requests from clients. It forwards the requests to 
the relevant service. In this service, Spring Cloud Gateway was used.

## Technologies
<ul>
    <li>Spring Cloud Gateway</li>
    <li>Spring Cloud Netflix Eureka Client</li>
    <li>Spring Security</li>
    <li>Redis (for rate limiting)</li>
    <li>Zipkin</li>
    <li>Sleuth</li>
</ul>

## application.properties File
Other services routes were defined in this file. Gateway forwards requests 
using these routes. Zipkin and sleuth properties are in here. Also, 
Spring Security Cors configurations were specified in application.properties file.

## Security Features

### Rate Limiting
The API Gateway includes rate limiting to protect against DDoS attacks and abusive clients. The implementation is designed to be non-intrusive for normal application use:

* **Smart Rate Limiting**:
  * Normal application paths for movies and authentication are excluded
  * Rate limiting only applies to potentially suspicious traffic patterns
  * Default rate limit: 300 requests per minute per IP (for development/testing)

* **Rate Limit Headers**:
  * `X-Rate-Limit`: Maximum requests allowed in the time window
  * `X-Rate-Limit-Remaining`: Remaining requests in the current time window
  * `X-Rate-Limit-Exceeded`: Set to "true" when rate limit is exceeded
  * `Retry-After`: Time in seconds until the limit resets

* **Backend Implementation**:
  * Simple in-memory rate limiter that works without additional infrastructure
  * Redis support is included but optional (not required to run the application)

### Error Handling
Custom error handling provides clear error messages when:
* Rate limits are exceeded (HTTP 429 Too Many Requests)
* Authentication fails (HTTP 401 Unauthorized)
* Access is denied (HTTP 403 Forbidden)

## Testing the Rate Limiter
A manual test class is provided in `src/test/java/com/kaankaplan/RateLimiterTest.java` to verify rate limiting functionality.
