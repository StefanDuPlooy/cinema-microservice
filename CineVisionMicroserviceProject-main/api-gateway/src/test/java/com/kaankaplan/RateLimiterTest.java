package com.kaankaplan;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.Assert.assertTrue;

/**
 * Manual test for rate limiting functionality
 * 
 * Note: This test should be run when the API Gateway is running locally.
 * It's designed to be run manually, not as part of the automated test suite.
 */
@RunWith(SpringRunner.class)
@SpringBootTest
public class RateLimiterTest {

    private static final String BASE_URL = "http://localhost:8080";
    private static final int THREAD_COUNT = 10;
    private static final int REQUESTS_PER_THREAD = 10;

    /**
     * Tests that the rate limiter is working by sending a lot of requests quickly
     * and checking that some of them get rejected with 429 Too Many Requests.
     */
    @Test
    public void testRateLimiter() throws InterruptedException {
        // Skip test if API Gateway is not running
        if (!isApiGatewayRunning()) {
            System.out.println("API Gateway not running, skipping test");
            return;
        }

        System.out.println("Running rate limiter test...");
        
        ExecutorService executorService = Executors.newFixedThreadPool(THREAD_COUNT);
        final AtomicInteger successCount = new AtomicInteger(0);
        final AtomicInteger rateLimitedCount = new AtomicInteger(0);
        final AtomicInteger otherErrorCount = new AtomicInteger(0);
        
        // Send requests from multiple threads
        for (int i = 0; i < THREAD_COUNT; i++) {
            executorService.submit(() -> {
                for (int j = 0; j < REQUESTS_PER_THREAD; j++) {
                    try {
                        int responseCode = sendRequest(BASE_URL + "/api/user/auth/login");
                        if (responseCode == 200) {
                            successCount.incrementAndGet();
                        } else if (responseCode == 429) {
                            rateLimitedCount.incrementAndGet();
                        } else {
                            otherErrorCount.incrementAndGet();
                        }
                    } catch (IOException e) {
                        otherErrorCount.incrementAndGet();
                    }
                    
                    // Small delay to make the test more realistic
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                    }
                }
            });
        }
        
        // Shutdown executor and wait for completion
        executorService.shutdown();
        executorService.awaitTermination(1, TimeUnit.MINUTES);
        
        // Print results
        System.out.println("Test complete:");
        System.out.println("Successful requests: " + successCount.get());
        System.out.println("Rate limited requests: " + rateLimitedCount.get());
        System.out.println("Other errors: " + otherErrorCount.get());
        
        // Verify that at least some requests were rate limited
        assertTrue("Expected some requests to be rate limited", rateLimitedCount.get() > 0);
    }
    
    private boolean isApiGatewayRunning() {
        try {
            HttpURLConnection connection = (HttpURLConnection) new URL(BASE_URL).openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(1000);
            connection.connect();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    private int sendRequest(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.connect();
        return connection.getResponseCode();
    }
}