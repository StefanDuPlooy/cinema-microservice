package com.kaankaplan.movieService.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentRequestDto {

    @NotBlank(message = "User ID is required")
    private String userId;
    
    @NotBlank(message = "Comment text is required")
    @Size(min = 2, max = 500, message = "Comment must be between 2 and 500 characters")
    private String commentText;
    
    @NotBlank(message = "Comment author name is required")
    private String commentBy;
    
    @NotBlank(message = "Comment author user ID is required")
    private String commentByUserId;
    
    @NotBlank(message = "Authorization token is required")
    private String token;
    
    @NotNull(message = "Movie ID is required")
    @Min(value = 1, message = "Movie ID must be positive")
    private int movieId;
}
