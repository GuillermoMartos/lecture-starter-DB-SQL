/* 
Select a list of actors along with the total budget of the movies they have appeared in
Shape
ID
First name
Last name
Total movies budget
*/
SELECT p.id, p.firstName, p.lastName, SUM(m.budget::numeric) as total_movies_budget
FROM PERSONA p
JOIN MOVIE_PERSONA mp 
ON mp.persona_id=id 
JOIN MOVIE m 
ON m.id = mp.movie_id
WHERE p.role = 'actor'
GROUP BY p.id;