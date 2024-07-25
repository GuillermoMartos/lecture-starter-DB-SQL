INSERT INTO COUNTRY (code, name) VALUES
('BOL', 'Bolivia'),
('EGP', 'Egypt'),
('UKR', 'Ukraine'),
('ARG', 'ARgentina');

INSERT INTO GENRE (id, name) VALUES
(uuid_generate_v4(), 'Action'),
(uuid_generate_v4(), 'Comedy');

INSERT INTO PERSONA (id, firstName, lastName, completeName, biography, dateOfBirth, gender, countryCode, role) VALUES
(uuid_generate_v4(), 'John', 'Doe', 'John Doe', 'An accomplished actor with many roles.', '1980-05-15', 'male', 'BOL', 'actor'),
(uuid_generate_v4(), 'Jane', 'Smith', 'Jane Smith',  'A talented actress known for her dramatic performances.', '1985-09-25', 'female', 'UKR', 'actor'),
(uuid_generate_v4(), 'Mike', 'Johnson', 'Mike Johnson', 'A director known for his action-packed films.', '1975-12-30', 'other', 'BOL', 'director'),
(uuid_generate_v4(), 'Emily', 'Davis', 'Emily Davis', 'An actress with a wide range of comedic roles.', '1990-07-10', 'not specified', 'ARG', 'actor');

INSERT INTO APP_USER (id, userName, firstName, lastName, email, password)
VALUES 
(uuid_generate_v4(), 'johndoe', 'John', 'Doe', 'john.doe@example.com', 'password123'),
(uuid_generate_v4(), 'janedoe', 'Jane', 'Doe', 'jane.doe@example.com', 'password456');

INSERT INTO MOVIE (id, title, description, budget, releaseDate, duration, countryCode, posterURL, director_id) VALUES
(uuid_generate_v4(), 'Epic Battle', 'A grand battle between heroes and villains.', 50000000, '2023-10-15', 120, 'BOL', 'http://example.com/epic_battle.jpg', (SELECT id FROM PERSONA WHERE firstName = 'Mike' AND lastName = 'Johnson')),
(uuid_generate_v4(), 'Comedy Night', 'A night of hilarious events and surprises.', 20000000, '2023-05-10', 90, 'UKR', 'http://example.com/comedy_night.jpg', (SELECT id FROM PERSONA WHERE firstName = 'Mike' AND lastName = 'Johnson')),
(uuid_generate_v4(), 'Adventure Quest', 'An adventurous quest through uncharted territories.', 30000000, '2023-08-20', 110, 'ARG', 'http://example.com/adventure_quest.jpg', (SELECT id FROM PERSONA WHERE firstName = 'Mike' AND lastName = 'Johnson'));

INSERT INTO FILE (id, MIMEType, key, fileType, publicURL, user_id, persona_id, movie_id, createdAt, updatedAt)
VALUES 
(uuid_generate_v4(), 'image/jpeg', 'profile_pic_johndoe', 'primaryPhoto', 'http://example.com/primaryPhoto/profile_johndoe.jpg', 
    (SELECT id FROM APP_USER WHERE userName = 'johndoe' LIMIT 1), 
    NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'profile_pic_janedoe', 'primaryPhoto', 'http://example.com/primaryPhoto/profile_janedoe.jpg', 
    (SELECT id FROM APP_USER WHERE userName = 'janedoe' LIMIT 1), 
    NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'poster_pic_epic_battle', 'moviePoster', 'http://example.com/moviePoster/epic_battle.jpg', 
    NULL, NULL, (SELECT id FROM MOVIE WHERE title = 'Epic Battle' LIMIT 1),  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'poster_pic_comedy_night', 'moviePoster', 'http://example.com/moviePoster/comedy_night.jpg', 
    NULL, NULL, (SELECT id FROM MOVIE WHERE title = 'Comedy Night' LIMIT 1),  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'poster_pic_adventure_quest', 'moviePoster', 'http://example.com/moviePoster/adventure_quest.jpg', 
    NULL, NULL, (SELECT id FROM MOVIE WHERE title = 'Adventure Quest' LIMIT 1),  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'photo_mike_johnson', 'primaryPhoto', 'http://example.com/primaryPhoto/photo_mike_johnson.jpg', 
    NULL, 
    (SELECT id FROM PERSONA WHERE completeName = 'Mike Johnson' LIMIT 1), NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'photo_emily_davis', 'primaryPhoto', 'http://example.com/photo_emily_davis.jpg', 
    NULL, 
    (SELECT id FROM PERSONA WHERE completeName = 'Emily Davis' LIMIT 1), NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'photo_jane_smith', 'primaryPhoto', 'http://example.com/photo_jane_smith.jpg', 
    NULL, 
    (SELECT id FROM PERSONA WHERE completeName = 'Jane Smith' LIMIT 1), NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'image/jpeg', 'photo_john_doe', 'primaryPhoto', 'http://example.com/photo_john_doe.jpg', 
    NULL, 
    (SELECT id FROM PERSONA WHERE completeName = 'John Doe' LIMIT 1), NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO CHARACTER (id, name, description, role, movie_id) VALUES
(uuid_generate_v4(), 'Hero', 'The main protagonist with exceptional skills.', 'leading', (SELECT id FROM MOVIE WHERE title = 'Epic Battle')),
(uuid_generate_v4(), 'Villain', 'The antagonist with a nefarious plan.', 'leading', (SELECT id FROM MOVIE WHERE title = 'Epic Battle')),
(uuid_generate_v4(), 'Sidekick', 'The loyal companion to the hero.', 'supporting', (SELECT id FROM MOVIE WHERE title = 'Epic Battle')),
(uuid_generate_v4(), 'Adventurer', 'Allways on front of the back.', 'leading', (SELECT id FROM MOVIE WHERE title = 'Adventure Quest')),
(uuid_generate_v4(), 'Sancho Panza', 'Allways on back of the front.', 'supporting', (SELECT id FROM MOVIE WHERE title = 'Adventure Quest')),
(uuid_generate_v4(), 'Doctor Titanio', 'Salutes in a scene', 'background', (SELECT id FROM MOVIE WHERE title = 'Adventure Quest')),
(uuid_generate_v4(), 'Comedian', 'Comedian is the pagliacci live story', 'leading', (SELECT id FROM MOVIE WHERE title = 'Comedy Night'));

INSERT INTO MOVIE_CHARACTER (movie_id, character_id) VALUES
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM CHARACTER WHERE name = 'Hero' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Epic Battle'))),
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM CHARACTER WHERE name = 'Villain' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Epic Battle'))),
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM CHARACTER WHERE name = 'Sidekick' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Epic Battle'))),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM CHARACTER WHERE name = 'Adventurer' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Adventure Quest'))),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM CHARACTER WHERE name = 'Sancho Panza' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Adventure Quest'))),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM CHARACTER WHERE name = 'Doctor Titanio' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Adventure Quest'))),
((SELECT id FROM MOVIE WHERE title = 'Comedy Night'), (SELECT id FROM CHARACTER WHERE name = 'Comedian' AND movie_id = (SELECT id FROM MOVIE WHERE title = 'Comedy Night')));

INSERT INTO MOVIE_PERSONA (movie_id, persona_id) VALUES
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM PERSONA WHERE completeName = 'John Doe')),
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM PERSONA WHERE completeName = 'Emily Davis')),
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM PERSONA WHERE completeName = 'Jane Smith')),
((SELECT id FROM MOVIE WHERE title = 'Comedy Night'), (SELECT id FROM PERSONA WHERE completeName = 'Emily Davis')),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM PERSONA WHERE completeName = 'Emily Davis')),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM PERSONA WHERE completeName = 'Jane Smith')),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM PERSONA WHERE completeName = 'John Doe'));

INSERT INTO MOVIE_GENRE (movie_id, genre_id) VALUES
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM GENRE WHERE name = 'Action')),
((SELECT id FROM MOVIE WHERE title = 'Comedy Night'), (SELECT id FROM GENRE WHERE name = 'Comedy')),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM GENRE WHERE name = 'Action'));

INSERT INTO USER_FAVORITES(movie_id, user_id)VALUES
((SELECT id FROM MOVIE WHERE title = 'Epic Battle'), (SELECT id FROM APP_USER WHERE userName = 'johndoe')),
((SELECT id FROM MOVIE WHERE title = 'Comedy Night'), (SELECT id FROM APP_USER WHERE userName = 'janedoe')),
((SELECT id FROM MOVIE WHERE title = 'Adventure Quest'), (SELECT id FROM APP_USER WHERE userName = 'janedoe'));
