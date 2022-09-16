use sakila;
-- 1 Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from sakila.film;
select title,length, rank() over(order by length) as"ranking by length" from sakila.film;

-- 2 Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title,length,rating,rank() over(order by title) as"Length by rating category" from sakila.film group by length;

-- 3 How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from sakila.film_category;  -- category_id, name,last_update
select * from sakila.category; -- category_id,name,last_update

select c.name, c.category_id, count(c.name)
from film_category f
join category c on f.category_id = c.category_id
group by c.category_id;

-- 4 Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from actor;  -- actor_id, first_name,last_name
select * from film_actor;  -- film_id

select first_name,last_name,count(*) as 'actor appears', rank() over(order by count(*) desc)as 'rank'
from actor 
inner join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id;


-- 5 Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select * from customer; -- customer_id, first_name,last_name,
select * from rental; -- count count(rental_id) rental_date
select first_name, last_name, count(rental_id)	
from sakila.customer 
join sakila.rental on customer.customer_id= rental.customer_id
group by customer.customer_id;



-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
-- film,inventory,rental count(rental_id) for each film
select * from film;-- title,rental_duration,
select * from inventory; -- film_id
select * from rental;-- inventory_id
select title,count(*) as "most rented film",rank() over(order by count(*) desc) as "ranking"
from sakila.film   
inner join sakila.inventory on inventory.film_id= film.film_id
inner join sakila.rental on rental.inventory_id= inventory.inventory_id
group by title;




