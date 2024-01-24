use sakila;
##Challenge 1##
#1.Determine the shortest and longest movie durations. in database duration is in minutes
SELECT MAX(length)AS 'max_duration', MIN(length) AS 'min_duration' FROM film f ;
SELECT length FROM film ORDER BY length DESC LIMIT 10;
#1.Express the average movie duration in hours and minutes. Don't use decimals.Hint: Look for floor and round functions.
SELECT FLOOR(AVG(length/60)) AS 'duration_in_hours',(round(AVG(length),0)-(FLOOR(AVG(length/60)))
AS 'duration_in_minutes' FROM film f ;

#2.1 Calculate the number of days that the company has been operating. it is 101 days
SELECT DATEDIFF (MIN(rental_date), MAX(return_date)) AS 'number of days operating'FROM rental r ;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
#monthname() or dayname() could also work
#Return 20 rows of results
SELECT rental_id, DATE_FORMAT(CONVERT (LEFT(rental_date,10),DATE),'%a') AS 'rental_start_day' , DATE_FORMAT(CONVERT (LEFT(rental_date,10),DATE),'%b') AS 'rental_start_month' 
FROM rental r 
LIMIT 20;
#2.3 Bonus
SELECT *,rental_date, 
CASE
	WHEN DAYNAME(rental_date)='Sun'THEN 'Weekend'
	WHEN DAYNAME(rental_date)='Sat'THEN 'Weekend'
	ELSE 'Workday'
END AS 'Day_type', rental_date as 'previous day'
FROM rental r 
LIMIT 20;

#3. retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.
SELECT title, IFNULL(DATEDIFF (return_date,rental_date),'Not Available') AS 'rental duration in days'
FROM film f, rental r 
ORDER BY title ASC
LIMIT 40;
#3.Bonus: concatenated first and last names of customers, along with the first 3 characters of their email address, ordered by last name in ascending order .

##Challenge2##
#1.1 The total number of films that have been released.
SELECT COUNT(*) FROM film f ;
#1.2 The number of films for each rating.
SELECT COUNT(*) FROM film f 
GROUP BY rating;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT COUNT(*) FROM film f 
GROUP BY rating
ORDER BY COUNT(*) DESC;
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round to two decimals. 
SELECT ROUND(AVG(length),2) FROM film f 
GROUP BY rating
ORDER BY AVG(length) DESC;
#2.2 Identify which ratings have a mean duration of over two hours
SELECT ROUND(AVG(length),2) FROM film f 
GROUP BY rating
HAVING AVG(length)>120;
#Bonus: determine which last names are not repeated in the table actor.
SELECT DISTINCT(last_name) FROM actor a ;
