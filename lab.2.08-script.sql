-- Lab 2.08

-- 1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM sakila.store s
JOIN sakila.address a
	USING (address_id)
JOIN sakila.city ci
	USING (city_id)
JOIN sakila.country co
	USING(country_id);

-- 2 Write a query to display how much business, in dollars, each store brought in.
SELECT se.store_id, SUM(amount) AS total_amount 
FROM sakila.store se
JOIN sakila.staff sf
	USING (store_id)
JOIN sakila.payment pt
	USING (staff_id)
GROUP BY se.store_id;

-- 3 Which film categories are longest?
SELECT SUM(f.length) AS film_length, c.name # If we interpret as the average film length though, we would have a different result. 
FROM sakila.category c 
JOIN sakila.film_category fc
	USING (category_id)
JOIN sakila.film f
	USING (film_id)
GROUP BY c.name
ORDER BY film_length DESC;

SELECT AVG(f.length) AS film_length, c.name 
FROM sakila.category c 
JOIN sakila.film_category fc
	USING (category_id)
JOIN sakila.film f
	USING (film_id)
GROUP BY c.name
ORDER BY film_length DESC;

-- 4 Display the most frequently rented movies in descending order.
SELECT f.title, i.film_id, COUNT(r.rental_id) AS rental_freq
FROM sakila.rental r
JOIN sakila.inventory i
	USING(inventory_id)
JOIN sakila.film f
	USING (film_id)
GROUP BY i.film_id
ORDER BY rental_freq DESC;

-- 5 List the top five genres in gross revenue in descending order.
SELECT c.name AS genres, SUM(p.amount) AS gross_revenue
FROM sakila.category c
JOIN sakila.film_category fc
	USING(category_id)
JOIN sakila.inventory i 
	USING (film_id)
JOIN sakila.rental r
	USING(inventory_id)
JOIN sakila.payment p 
	USING (rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;
    
-- 6 Is "Academy Dinosaur" available for rent from Store 1? Yes.
SELECT i.inventory_id, f.title, s.store_id, r.return_date, (r.last_update > r.return_date) AS available
FROM sakila.store s
JOIN sakila.inventory i
	USING (store_id)
JOIN sakila.film f
	USING (film_id)
JOIN sakila.rental r 
	USING(inventory_id)
WHERE r.return_date IS NOT NULL 
	AND f.title = 'ACADEMY DINOSAUR'
    AND s.store_id = 1
GROUP BY i.inventory_id;

-- 7 Get all pairs of actors that worked together.
SELECT DISTINCT fa.film_id
	, fa.actor_id, a.first_name, a.last_name
    , fb.film_id
    , fb.actor_id ,b.first_name, b.last_name
FROM sakila.actor a
JOIN film_actor fa
	ON a.actor_id = fa.actor_id
JOIN film_actor fb
	ON fa.film_id = fb.film_id
JOIN sakila.actor b
	ON fb.actor_id = b.actor_id
WHERE a.actor_id != b.actor_id
ORDER BY fa.film_id;

-- 8 Get all pairs of customers that have rented the same film more than 3 times. ## subqueries
-- 9 For each film, list actor that has acted in more films. ## subqueries