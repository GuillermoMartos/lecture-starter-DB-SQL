/* 
Select directors along with the average budget of the movies they have directed
Shape
Director ID
Director name (concatenation of first and last names)
Average budget
*/

SELECT d.id, d.firstName, d.lastName, m.budget
FROM persona d
JOIN MOVIE_PERSONA mp
ON mp.persona_id = d.id
JOIN MOVIE m
ON mp.movie_id = m.id
WHERE d.role='director';

SELECT d.id, CONCAT(d.firstName, ' ', d.lastName) AS complete_name , ROUND(AVG(m.budget), 2) as average_budgets
FROM MOVIE m
JOIN PERSONA d
ON d.id=m.director_id
GROUP BY d.id;