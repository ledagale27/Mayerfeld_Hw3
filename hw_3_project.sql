-- 1.  List the last names of actors (alphabetically), as well as how many actors have that last name.
SELECT
	last_name, COUNT(*) AS "actor_count"
FROM
	actor
GROUP BY 
	last_name
ORDER BY
	last_name ASC;


-- 2.  List last names of actors and the number of actors who have that last name, but only for names 
-- that are shared by at least three actors, sort so that last name with the highest number of actors appears at the top.

SELECT
	last_name, COUNT(*) AS actor_count
FROM 
	actor
GROUP BY 
	last_name
HAVING 
	COUNT(*) >= 3
ORDER BY 
	actor_count DESC;



-- 3.  List all comedy films (regardless of other genres) by displaying the title and film year and 
-- sort by revenue_mils so that the highest appears first.

SELECT 
	title AS "Title", 
	film_year AS "Film_year",
	revenue_mils  AS "Revenue_mils"
FROM 
	movies
WHERE
	genre LIKE '%Comedy%'
AND
	revenue_mils IS NOT NULL
ORDER BY 
	revenue_mils DESC;




-- 4.  Display how many films there are in the database for each year. Output should only contain the
-- year and number of films with oldest films appearing first.

SELECT
	film_year , count(film_rank)
FROM 
	movies
GROUP BY 
	film_year
ORDER BY 
	film_year ASC;


-- 5.  Show all directors who have directed more than 4 films. The output should contain their names and
-- number of films they have directed. The output should show directors with more films at the top, and if
-- there is a tie, sort alphabetically.

SELECT
	director, count(film_rank)
FROM 
	movies
GROUP BY
	director
HAVING
	count(film_rank) > 4
ORDER BY
	count(film_rank) DESC, director ASC;
	


-- 6.  Display the highest revenue amount for each year – output should show the film_year and revenue_mils
-- and it should show oldest films first.

SELECT
	film_year, MAX(revenue_mils)
FROM
	movies
GROUP BY
	film_year 
ORDER BY 
	film_year ASC;


-- 7.  List highest postal codes for all districts staring with either A, B, C, or D ordered by the starting letter.

SELECT
	MAX(postal_code), district 
FROM
	address
WHERE
	LEFT(district,1) < 'E' AND district != ''
GROUP BY
	district
ORDER BY 
	district ASC;



-- 8.  Show the ID and average money spent, rounded to 3 decimal points, from 15 top spending customers 
-- (by average spent) that spent below 4.5 so that customers who spent more appear at the top.


SELECT 
	customer_id, ROUND(AVG(p.amount),3) AS avg_spent
FROM
	payment p
GROUP BY 
	customer_id
HAVING
	AVG(p.amount) < 4.5
ORDER BY
	AVG(p.amount) DESC 
LIMIT 
	15;


-- 9.  Show the total number of actors who share their last name with 3 or more other actors.

SELECT 
	SUM(a.count_actors)
FROM 
(SELECT 
	last_name, COUNT(last_name) AS count_actors
FROM
	actor
GROUP BY
	last_name
HAVING
	COUNT(last_name) >= 3) AS a;


-- 10. Show the total revenue by month. Hint: Research “EXTRACT”.
