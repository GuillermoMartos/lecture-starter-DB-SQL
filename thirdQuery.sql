/* 
Retrieve a list of all users along with their favorite movies as array of identifiers
Shape
ID
Username
Favorite movie IDs
*/
SELECT u.id, u.userName, array_agg(uf.movie_id) as pelis
FROM APP_USER u
JOIN USER_FAVORITES uf
ON uf.user_id = u.id
GROUP BY u.id;