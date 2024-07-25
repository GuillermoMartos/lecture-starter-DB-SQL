SELECT p.id, p.firstName, p.lastName, SUM(m.budget::numeric) as total_movies_budget
from persona p
JOIN MOVIE_PERSONA mp 
on mp.persona_id=id 
JOIN MOVIE m 
on m.id = mp.movie_id
WHERE p.role = 'actor'
GROUP BY p.id;