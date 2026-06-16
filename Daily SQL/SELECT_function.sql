USE mydatabase;

-- All data from table

SELECT *
FROM customers;

-- Pick few columns

SELECT 
		first_name,
		country,
		score
FROM customers;

-- Retrive customer with a score not equal to 0

SELECT *
FROM customers
WHERE score != 0;

-- Reteive customers from germany 

SELECT *
FROM customers
WHERE country = 'Germany';

-- Retrive all customers and sort the result by highest scores first

SELECT *
FROM customers
ORDER BY score DESC;

-- Retrive all customers and sort the results by country and then by the highest score

SELECT *
FROM customers
ORDER BY country ASC, score	DESC;

-- Find total scores of each counrty

SELECT 
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country;

-- FInd total score and total number of customer of customers for each country

SELECT
		country,
		SUM(score) AS total_score,
		COUNT(id) AS total_customers
FROM customers
GROUP BY country;

-- Find avg scores of each country considering only customers with a score not equal to 0
-- And return only those countries with an avg greater than 430 

SELECT 
		country,
		AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING avg_score > 430;

-- Return unique list of all countries

SELECT DISTINCT
				country
FROM customers;

-- Reterive only 3 customers

SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- 