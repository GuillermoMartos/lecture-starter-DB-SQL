/*
Select detailed information about a movie with ID of 1
Shape
ID
Title
Release date
Duration
Description
Poster (poster file information in JSON format)
Director (person information in JSON format)
    ID
    First name
    Last name
    Photo (primary photo file information in JSON format)
Actors (array of JSON objects)
    ID
    First name
    Last name
    Photo (primary photo file information in JSON format)
Genres (array of objects in JSON format)
    ID
    Name
*/

SELECT m.id, m.title, m.releaseDate, m.duration, m.description,
    json_build_object(
        'movie poster URL', mf.publicURL,
        'MIME Type', mf.MIMEType
    ) AS poster, 
    json_build_object(
        'ID', d.id,
        'FirstName', d.firstName,
        'LastName', d.lastName,
        'Photo', json_build_object(
            'director photo URL', df.publicURL,
            'MIME Type', df.MIMEType
        )
    ) AS director,
    (SELECT json_agg(
        json_build_object(
            'name', a.completeName
        )
    ) 
    FROM MOVIE_PERSONA ma
    JOIN PERSONA a ON a.id = ma.persona_id
    WHERE ma.movie_id = m.id AND a.role = 'actor') AS actors,
    (SELECT json_agg(
        json_build_object(
            'name', g.name,
            'ID', g.id
        )
    )
    FROM MOVIE_GENRE mg
    JOIN GENRE g ON g.id = mg.genre_id
    WHERE mg.movie_id = m.id) AS genre
FROM MOVIE m
JOIN FILE mf ON mf.movie_id = m.id
JOIN PERSONA d ON d.id = m.director_id
JOIN FILE df ON df.persona_id = m.director_id
WHERE m.id= 1
AND d.role = 'director'
GROUP BY 
    m.id, 
    m.title, 
    m.releaseDate, 
    m.duration, 
    m.description, 
    mf.publicURL, 
    mf.MIMEType, 
    d.id, 
    d.firstName, 
    d.lastName, 
    df.publicURL, 
    df.MIMEType;