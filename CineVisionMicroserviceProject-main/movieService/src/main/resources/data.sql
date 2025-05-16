-- Drop database if it exists and recreate it
-- DROP DATABASE IF EXISTS cine_vision;
-- CREATE DATABASE cine_vision;

-- Categories
INSERT INTO category (category_id, category_name) VALUES (1, 'Action');
INSERT INTO category (category_id, category_name) VALUES (2, 'Adventure');
INSERT INTO category (category_id, category_name) VALUES (3, 'Comedy');
INSERT INTO category (category_id, category_name) VALUES (4, 'Drama');
INSERT INTO category (category_id, category_name) VALUES (5, 'Horror');
INSERT INTO category (category_id, category_name) VALUES (6, 'Science Fiction');
INSERT INTO category (category_id, category_name) VALUES (7, 'Thriller');
INSERT INTO category (category_id, category_name) VALUES (8, 'Fantasy');

-- Directors
INSERT INTO director (director_id, director_name) VALUES (1, 'Christopher Nolan');
INSERT INTO director (director_id, director_name) VALUES (2, 'Steven Spielberg');
INSERT INTO director (director_id, director_name) VALUES (3, 'Quentin Tarantino');
INSERT INTO director (director_id, director_name) VALUES (4, 'James Cameron');
INSERT INTO director (director_id, director_name) VALUES (5, 'Martin Scorsese');
INSERT INTO director (director_id, director_name) VALUES (6, 'Denis Villeneuve');

-- Movies (that are currently showing)
INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (1, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 169, '2014-11-07', true, 'https://www.youtube.com/watch?v=zSWdZVtXT7E', 6, 1);

INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (2, 'The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 152, '2008-07-18', true, 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 1, 1);

INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (3, 'Jurassic Park', 'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the park''s cloned dinosaurs to run loose.', 127, '1993-06-11', true, 'https://www.youtube.com/watch?v=QWBKEmWWL38', 2, 2);

INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (4, 'Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 154, '1994-10-14', true, 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', 7, 3);

-- Movies (coming soon)
INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (5, 'Dune: Part Two', 'Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family.', 166, '2024-03-01', false, 'https://www.youtube.com/watch?v=WiuCG8jQ1F8', 6, 6);

INSERT INTO movie (movie_id, movie_name, description, duration, release_date, is_display, movie_trailer_url, category_id, director_id) 
VALUES (6, 'Killers of the Flower Moon', 'Members of the Osage tribe in the United States are murdered under mysterious circumstances in the 1920s, sparking a major F.B.I. investigation.', 206, '2023-10-20', false, 'https://www.youtube.com/watch?v=EP34Yoxs3FQ', 4, 5);

-- Movie Images
INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (1, 'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg', 1);

INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (2, 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg', 2);

INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (3, 'https://m.media-amazon.com/images/M/MV5BMjM2MDgxMDg0Nl5BMl5BanBnXkFtZTgwNTM2OTM5NDE@._V1_.jpg', 3);

INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (4, 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg', 4);

INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (5, 'https://m.media-amazon.com/images/M/MV5BODI0YjNhNjUtYjM0My00MTUwLWFlYTMtMWI2NGUzYjhkZWY5XkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg', 5);

INSERT INTO movie_image (image_id, image_url, movie_movie_id) 
VALUES (6, 'https://m.media-amazon.com/images/M/MV5BNjQwOGM2YTItMGY0NS00ZTFhLWE3NDQtYjIyMTZiZjRjNGM1XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg', 6);

-- Actors
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (1, 'Matthew McConaughey', 1);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (2, 'Anne Hathaway', 1);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (3, 'Jessica Chastain', 1);

INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (4, 'Christian Bale', 2);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (5, 'Heath Ledger', 2);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (6, 'Aaron Eckhart', 2);

INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (7, 'Sam Neill', 3);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (8, 'Laura Dern', 3);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (9, 'Jeff Goldblum', 3);

INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (10, 'John Travolta', 4);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (11, 'Samuel L. Jackson', 4);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (12, 'Uma Thurman', 4);

INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (13, 'Timothée Chalamet', 5);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (14, 'Zendaya', 5);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (15, 'Rebecca Ferguson', 5);

INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (16, 'Leonardo DiCaprio', 6);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (17, 'Robert De Niro', 6);
INSERT INTO actor (actor_id, actor_name, movie_movie_id) VALUES (18, 'Lily Gladstone', 6);

-- Actor Images
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (1, 'https://m.media-amazon.com/images/M/MV5BMTg0MDc3ODUwOV5BMl5BanBnXkFtZTcwMTk2NjY4Nw@@._V1_UX214_CR0,0,214,317_AL_.jpg', 1);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (2, 'https://m.media-amazon.com/images/M/MV5BMTRhNzQ3NGMtZmQ1Mi00ZTViLTk3OTgtOTk0YzE2YTgwMmFjXkEyXkFqcGdeQXVyNzg5MzIyOA@@._V1_UY317_CR51,0,214,317_AL_.jpg', 2);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (3, 'https://m.media-amazon.com/images/M/MV5BNTA2NTY1ODQxNF5BMl5BanBnXkFtZTgwNDU5NTcxMDI@._V1_UX214_CR0,0,214,317_AL_.jpg', 3);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (4, 'https://m.media-amazon.com/images/M/MV5BMTkxMzk4MjQ4MF5BMl5BanBnXkFtZTcwMzExODQxOA@@._V1_UX214_CR0,0,214,317_AL_.jpg', 4);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (5, 'https://m.media-amazon.com/images/M/MV5BMTI2NTY0NzA4MF5BMl5BanBnXkFtZTYwMjE1MDE0._V1_UX214_CR0,0,214,317_AL_.jpg', 5);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (6, 'https://m.media-amazon.com/images/M/MV5BMTc4MTAyNzMzNF5BMl5BanBnXkFtZTcwMzQ5MzQzMg@@._V1_UY317_CR6,0,214,317_AL_.jpg', 6);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (7, 'https://m.media-amazon.com/images/M/MV5BMjM5ODI2NDM1Nl5BMl5BanBnXkFtZTgwNTI1MTEwOTE@._V1_UY317_CR13,0,214,317_AL_.jpg', 7);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (8, 'https://m.media-amazon.com/images/M/MV5BMjI3NzY0MDQxMF5BMl5BanBnXkFtZTcwNzMwMzcyNw@@._V1_UX214_CR0,0,214,317_AL_.jpg', 8);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (9, 'https://m.media-amazon.com/images/M/MV5BMzU3ODMwNzQ1NF5BMl5BanBnXkFtZTcwMTYyMTkxOA@@._V1_UY317_CR8,0,214,317_AL_.jpg', 9);
INSERT INTO actor_image (image_id, image_url, actor_actor_id) 
VALUES (10, 'https://m.media-amazon.com/images/M/MV5BMTUwNjQ0ODkxN15BMl5BanBnXkFtZTcwMDc5NjQwNw@@._V1_UY317_CR11,0,214,317_AL_.jpg', 10);

-- Cities
INSERT INTO city (city_id, city_name, movie_id) VALUES (1, 'Johannesburg', 1);
INSERT INTO city (city_id, city_name, movie_id) VALUES (2, 'Cape Town', 1);
INSERT INTO city (city_id, city_name, movie_id) VALUES (3, 'Durban', 1);
INSERT INTO city (city_id, city_name, movie_id) VALUES (4, 'Pretoria', 2);
INSERT INTO city (city_id, city_name, movie_id) VALUES (5, 'Port Elizabeth', 2);
INSERT INTO city (city_id, city_name, movie_id) VALUES (6, 'Bloemfontein', 3);
INSERT INTO city (city_id, city_name, movie_id) VALUES (7, 'East London', 3);
INSERT INTO city (city_id, city_name, movie_id) VALUES (8, 'Pietermaritzburg', 4);

-- Saloons
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (1, 'Saloon A', 1);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (2, 'Saloon B', 1);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (3, 'Saloon C', 2);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (4, 'Saloon D', 2);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (5, 'Saloon E', 3);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (6, 'Saloon F', 4);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (7, 'Saloon G', 5);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (8, 'Saloon H', 6);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (9, 'Saloon I', 7);
INSERT INTO saloon (saloon_id, saloon_name, city_id) VALUES (10, 'Saloon J', 8);

-- Movie Saloon Times
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (1, '10:00', 1, 1);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (2, '13:30', 1, 1);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (3, '17:00', 1, 1);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (4, '20:30', 1, 1);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (5, '11:15', 1, 2);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (6, '14:45', 1, 2);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (7, '18:15', 1, 2);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (8, '21:45', 1, 2);

INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (9, '09:30', 2, 3);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (10, '12:00', 2, 3);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (11, '14:30', 2, 3);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (12, '17:00', 2, 3);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (13, '19:30', 2, 3);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (14, '22:00', 2, 3);

INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (15, '10:45', 3, 5);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (16, '13:15', 3, 5);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (17, '15:45', 3, 5);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (18, '18:15', 3, 5);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (19, '20:45', 3, 5);

INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (20, '11:30', 4, 6);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (21, '14:30', 4, 6);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (22, '17:30', 4, 6);
INSERT INTO movie_saloon_time (id, movie_begin_time, movie_id, saloon_id) VALUES (23, '20:30', 4, 6);

-- Comments
INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (1, 'One of the best sci-fi movies I''ve ever seen. The visuals and soundtrack are mind-blowing!', 'John Smith', '1', 1);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (2, 'The story gets a bit confusing towards the end, but overall it''s a masterpiece.', 'Sarah Johnson', '2', 1);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (3, 'Heath Ledger''s performance as the Joker is legendary. Definitely deserved the Oscar.', 'Michael Brown', '3', 2);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (4, 'The best superhero movie ever made, period.', 'Emma Davis', '4', 2);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (5, 'This movie was revolutionary when it came out. The dinosaurs still look amazing even today!', 'David Wilson', '5', 3);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (6, 'A classic that never gets old. I watch it with my kids and they love it as much as I did.', 'Jennifer Moore', '6', 3);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (7, 'This movie changed cinema forever. The non-linear storytelling is brilliant.', 'Robert Taylor', '7', 4);

INSERT INTO comment (comment_id, comment_text, comment_by, comment_by_user_id, movie_movie_id) 
VALUES (8, 'Tarantino at his best. The dialogue is unmatched.', 'Amanda Martinez', '8', 4);