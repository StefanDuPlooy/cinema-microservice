package com.kaankaplan.movieService.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieRequestDto {

    @NotBlank(message = "Movie name is required")
    @Size(min = 1, max = 100, message = "Movie name must be between 1 and 100 characters")
    private String movieName;
    
    @NotBlank(message = "Description is required")
    @Size(min = 10, max = 2000, message = "Description must be between 10 and 2000 characters")
    private String description;
    
    @Min(value = 1, message = "Duration must be positive")
    @Max(value = 1000, message = "Duration must be less than 1000 minutes")
    private int duration;
    
    @NotNull(message = "Release date is required")
    private Date releaseDate;
    
    @NotBlank(message = "Trailer URL is required")
    private String trailerUrl;
    
    private boolean isInVision;
    
    @Min(value = 1, message = "Category ID must be positive")
    private int categoryId;
    
    @Min(value = 1, message = "Director ID must be positive")
    private int directorId;
    
    @NotEmpty(message = "At least one actor must be selected")
    private List<Integer> actors;
    
    @NotEmpty(message = "At least one city must be selected")
    private List<Integer> cities;
    
    @NotBlank(message = "User access token is required")
    private String userAccessToken;
}
