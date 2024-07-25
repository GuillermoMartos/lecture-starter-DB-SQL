/*
Select detailed information about movies that meet criteria below
Criteria
Belong to a country with ID of 1.
Were released in 2022 or later.
Have a duration of more than 2 hours and 15 minutes.
Include at least one of the genres: Action or Drama.
Shape
ID
Title
Release date
Duration
Description
Poster (poster file information as JSON)
Director (director information as JSON)
    ID
    First name
    Last name
*/

SELECT m.id, m.title, m.releaseDate, m.duration, m.description, 
json_build_object(
        'movie poster URL', mf.publicURL,
        'MIME Type', mf.MIMEType
    ) AS poster, 
json_build_object(
        'ID', d.id,
        'FirstName', d.firstName,
        'LastName', d.lastName
    ) AS director
FROM MOVIE m
JOIN COUNTRY c
ON c.code = m.countryCode
JOIN FILE mf
ON mf.movie_id = m.id
JOIN PERSONA d
ON d.id= m.director_id
JOIN MOVIE_GENRE mg
ON mg.movie_id = m.id
JOIN GENRE g
ON g.id = mg.genre_id
WHERE d.role='director'
AND c.id=1
AND m.duration >135
AND (g.name = 'Action' OR g.name = 'Drama')
AND m.releaseDate > '2022-01-01';