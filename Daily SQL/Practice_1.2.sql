
-- Select data base to use

-- USE db_sql_tutorial

-- Select customers data from database

-- SELECT *
-- FROM customers

-- Select orders data from database

-- SELECT *
-- FROM orders

-- Retrive only first name and country of all customers

-- SELECT
##	first_name,
##	country
-- FROM customers

-- Distinct reomoves duplicate data in the result
-- List all countries of all customers without duplicates

-- SELECT DISTINCT
##customerscustomers	country
-- FROM customers

-- DBMS does not share data with you in a specific order
-- In such cases we can use the SORT for a perticular order
-- Retrive the customers where the result is sorted by scores (small first) 

-- SELECT *
-- FROM customers
-- ORDER BY score ASC

-- Retrive the customers where the result is sorted by scores (high first)

-- SELECT *
-- FROM customers
-- ORDER BY score DESC

-- Rertive all customers sorting the result by country (alphabatically) and then by score (highest first)

-- SELECT *
-- FROM customers
-- ORDER BY country ASC, score DESC

-- We can use the same command with column number as well but if datatable changes 
-- Then you may need to changethe column numbers manually, so better to write the full name of column

-- SELECT *
-- FROM customers
-- ORDER BY 4 ASC, 5 DESC

-- Where filtres rows based on specified conditions eg conditions from a certain countries
-- List only gernam customers

-- SELECT *
-- FROM customers
-- WHERE country = 'Germany'

-- Select customer where score is higher than 500

-- SELECT *
-- FROM customers
-- WHERE score > 500

-- Find all customers with scores less than 500

-- SELECT *
-- FROM customers
-- WHERE score < 500

-- Find all customers with scores less than and equal to 500

-- SELECT *
-- FROM customers
-- WHERE score <= 500

-- Find all customers with scores higher than and equal to 500

-- SELECT *
-- FROM customers
-- WHERE score >= 500

-- Fimd all non german customers

-- SELECT *
-- FROM customers
-- WHERE country != 'Germany'

-- Logical operator
-- Find customers who come from germany and score less than 400

-- SELECT *
-- FROM customers
-- WHERE country = 'Germany' AND score < 400

-- Find customers who come from germany or score less than 400

-- SELECT *
-- FROM customers
-- WHERE country = 'Germany' OR score < 400

-- Find customers who score is not less than 400

-- SELECT *
-- FROM customers
-- WHERE NOT score < 400

--  Find all customers with scores falling between 100 to 500

-- SELECT *
-- FROM customers
-- WHERE score BETWEEN 100 AND 500

-- OR 

-- SELECT *
-- FROM customers
-- WHERE score >= 100 AND score <= 500

-- Find all customers whose ID is equal to 1,2 and 5

-- SELECT *
-- FROM customers
-- WHERE customer_id IN (1,2,5)

-- OR

-- SELECT *
-- FROM customers
-- WHERE customer_id = 1
-- OR customer_id = 2
-- OR customer_id = 3

-- Find all customers whose first name starts wth M

-- SELECT *
-- FROM customers
-- WHERE first_name like '%M%'

-- Find all customers whose first name ends wth n

-- SELECT *
-- FROM customers
-- WHERE first_name like '%n'

-- Find all customers whose first name contains R some where

-- SELECT *
-- FROM customers
-- WHERE first_name like '%R%'

-- Find all customers whose first name contains R in third position

-- SELECT *
-- FROM customers
-- WHERE first_name like '__r%'

-- SQL JOINS 

-- SELECT 
-- c.customer_id AS cid -- cid here is the alias (short form) for customers_id
-- FROM customers AS c -- c here is the alias (short form) for customers

-- INNER JOINT -- list of cutomer ID, first name, order id, quantity. Exclude the customers who have not placed any order by

-- SELECT 
##	c.customer_id,
##	c.first_name,
##	o.order_id,
##	o.quantity
-- FROM customers AS c -- Need to have join type and join key
-- INNER JOIN orders AS o -- Need to have join type and join key
-- ON c.customer_id = o.customer_id

-- LEFT JOIN -- list of cutomer ID, first name, order id, quantity. Include the customers who have not placed any order by

-- SELECT
##	c.customer_id,
##	c.first_name,
##	o.order_id,
##	o.quantity
-- FROM customers AS c -- Need to have join type and join key
-- LEFT JOIN orders AS o -- Need to have join type and join key
-- ON c.customer_id = o.customer_id

-- RIGHT JOIN -- list of cutomer ID, first name, order id, quantity. Include all orders regardless of wheather there is a matching customer_id

-- SELECT
##	c.customer_id,
##	c.first_name,
##	o.order_id,
##	o.quantity
-- FROM customers AS c -- Need to have join type and join key
-- RIGHT JOIN orders AS o -- Need to have join type and join key
-- ON c.customer_id = o.customer_id

-- FULL OUTER JOIN does not work on my sql but we can Union left and right --
-- SELECT
##	c.customer_id,
##	c.first_name,
##	o.order_id,
##	o.quantity
-- FROM customers AS c -- Need to have join type and join key
-- LEFT JOIN orders AS o -- Need to have join type and join key
-- ON c.customer_id = o.customer_id
-- UNION
-- SELECT
##	c.customer_id,
##	c.first_name,
##	o.order_id,
##	o.quantity
-- FROM customers AS c -- Need to have join type and join key
-- RIGHT JOIN orders AS o -- Need to have join type and join key
-- ON c.customer_id = o.customer_id

-- List first name, last nane and country of all persons from customers and employees
-- SELECT
##	first_name AS person_first_name,
##	last_name AS person_last_name,
##	country AS person_country_name
-- FROM customers
-- UNION
-- SELECT
##	first_name,
##	last_name,
##	emp_country
-- FROM employees

-- SQL -- Aggregate Functions: COUNT, SUM, AVG, MAX, MIN 
-- COUNT -- Number of rows in table
-- Find total number of customers

-- SELECT COUNT(*) AS total_customers
-- FROM customers ## provide number of rows

-- SELECT COUNT(*)
-- FROM customers

-- SUM -- Find total quantity of the orders
-- SELECT SUM(quantity)
-- FROM orders

-- SELECT SUM(quantity) AS sum_quantity
-- FROM orders

-- Averrage -- Find total of all customers

-- SELECT AVG(score) AS average_score
-- FROM customers

-- MIN and MAX - find highest score of the table

-- SELECT MIN(score) AS minimum_score
-- FROM customers

-- SELECT MAX(score) AS average_score
-- FROM customers

-- CONCAT --
-- SELECT 
-- CONCAT(first_name,' ',last_name) AS customer_name
-- FROM customers

-- UPPER LOWER case -- doing this will not update the content as the content remain same-

-- SELECT 
-- LOWER(first_name) AS upper_first_name,
-- UPPER(last_name) AS lower_last_name
-- FROM customers

-- -- TRIM to remove un necesary space infront of or behind the name or text in a column of a table
-- -- LTRIM
-- -- RTRIM
-- -- TRIM

-- SELECT
-- TRIM(last_name) AS clean_last_name
-- FROM customers

-- -- Calculate lenght of characters in last name of all customers

-- SELECT last_name,
-- UPPER(last_name) AS upper_last_name,
-- TRIM(last_name) AS clean_last_name,
-- LENGTH(last_name) AS lenght_last_name
-- FROM customers

-- -- Substring column, start, length -- its like index in python but ut strts with 1 instead of 0

-- SELECT last_name,
-- SUBSTRING(last_name,2,3) AS sub_last_name
-- FROM customers

-- -- Find total number of customers for each country
-- SELECT 
-- COUNT(*) AS total_customers,
--    country
-- FROM customers
-- GROUP BY country
-- ORDER BY COUNT(*) ASC

-- Find highest score of customers for each country
-- SELECT
-- MAX(score) AS max_score,
-- country
-- FROM customers
-- GROUP BY country

-- -- Find the total number of customers for each country and only include countries that have more than 1 customers
-- SELECT
-- 	COUNT(*) AS total_customers,
--     country
-- FROM customers
-- WHERE country != 'USA'
-- GROUP BY country
-- HAVING COUNT(*) > 1

-- All orders placed from customers whose scores are higher than 500 using the customer id

-- SELECT *
-- FROM orders
-- WHERE customer_id IN
-- ( SELECT customer_id FROM customers WHERE score > 500 )

-- OR we can also use 

-- SELECT *
-- FROM orders AS o
-- WHERE EXISTS ( SELECT 1
-- FROM customers AS c
-- WHERE c.customer_id = o.customer_id 
-- AND score > 500 )

-- INSERT the new customer in the table
-- INSERT INTO customers
-- VALUE(6,'Anna','Nixon','UK', NULL)

-- INSERT INTO customers
-- VALUE(7,'Max','Lang',NULL, NULL)

-- INSERT INTO customers
-- (customer_id,first_name, last_name)
-- VALUE(8,'Mohan','Nath')

-- DELETE FROM customers
-- WHERE customer_id IN (6,7,8)

-- if you want to keep table and delet content you may use TRUNCATE

-- Create new tabel called persons with 4 column ID, person name, date of birth and phone
-- CREATE TABLE db_sql_tutorial.persons(id INT PRIMARY KEY AUTO_INCREMENT,
-- person_name VARCHAR(50) NOT NULL,
-- birth_date DATE,
-- phone VARCHAR(15) NOT NULL UNIQUE
-- )

-- Add email section to table basically alter the table

-- ALTER TABLE persons
-- ADD email VARCHAR(20) NOT NULL

-- DROP TABLE
-- DROP TABLE persons

