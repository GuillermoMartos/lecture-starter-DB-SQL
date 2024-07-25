/* 
Select movies released in the last 5 years with the number of actors who have appeared in each movie
Shape
ID
Title
Actors count
*/
SELECT m.id, m.title, COUNT(p.completeName) as actors_featured
FROM MOVIE m
JOIN MOVIE_PERSONA mp
ON mp.movie_id = m.id
JOIN PERSONA p
ON p.id= mp.persona_id
WHERE p.role='actor'
GROUP BY m.id
;
