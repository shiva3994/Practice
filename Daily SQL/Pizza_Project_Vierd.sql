-- 1 Display all the columns of pizzas table
-- SELECT *
-- FROM pizzas

-- 2 Write an sql query to list all pizzas sorted by price.
-- ORDER BY price DESC

-- 3 Show me pizza detail where price is greater than 15 and type bbq_ckn
-- WHERE price > 15 AND pizza_type_id = 'bbq_ckn'

-- 4 Write an sql query to count the total number of orders placed.
-- SELECT COUNT(order_id) AS total_order
-- OR
-- SELECT COUNT(*) from orders
-- FROM order_details

-- 5 Display columns from multiple table together
-- SELECT * 
-- FROM 
-- pizzas,
-- orders,
-- pizza_types

-- 6 Update the price of all the bbq_ckn to 18
-- UPDATE pizzas SET price = 18
-- WHERE pizza_type_id = 'bbq_ckn';

-- SELECT * FROM pizzas
-- WHERE pizza_type_id = 'bbq_ckn';

-- 7 Display the pizza name category size and price
-- SELECT 
-- 		pizza_types.name,
-- 		pizza_types.category,
-- 		pizzas.size,
-- 		pizzas.price
-- FROM pizza_types
-- JOIN pizzas
-- 		ON pizzas.pizza_type_id = pizza_types.pizza_type_id

-- 8 Total price of each pizza ordered
-- SELECT
-- 		name,
-- 		SUM(quantity*price) AS total_price
-- FROM pizzas
-- JOIN pizza_types
-- 		ON pizzas.pizza_type_id = pizza_types.pizza_type_id
-- JOIN order_details
-- 		ON order_details.pizza_id = pizzas.pizza_id
-- GROUP BY pizza_types.name
-- ORDER BY total_price desc

-- 9 Write an sql query to list pizzas with total orders greater than a specified amount. (900)

-- SELECT
-- 		pizza_types.name,
-- 		SUM(pizzas.price) AS total_price
-- FROM pizzas
-- JOIN pizza_types
-- 		ON pizzas.pizza_type_id = pizza_types.pizza_type_id
-- JOIN order_details
-- 		ON order_details.pizza_id = pizzas.pizza_id
-- GROUP BY pizza_types.name
-- HAVING total_price > 900
-- ORDER BY pizza_types.name ASC

-- 9.	Write an sql query to list pizzas with total orders greater than 180.
-- SELECT 
-- 		name,
-- 		COUNT(order_id) AS Total_Order
-- FROM pizza_types 
-- JOIN pizzas
-- 		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- JOIN order_details 
-- 		ON pizzas.pizza_id =order_details.pizza_id
-- GROUP BY name HAVING Total_order > 180 
-- ORDER BY Total_Order DESC;

-- 10 Write an sql query to list the top 5 customers by the total value of their orders
-- SELECT 
-- 		name,
-- 		COUNT(order_id) AS Total_Order
-- FROM pizza_types 
-- JOIN pizzas
-- 		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- JOIN order_details 
-- 		ON pizzas.pizza_id =order_details.pizza_id
-- GROUP BY name
-- ORDER BY Total_Order DESC
-- LIMIT 5

-- 11 Write an sql query to determine the frequency of orders (e.g., daily, weekly).
-- SELECT 
--     WEEK(date) AS weekly, 
--     COUNT(order_id) AS order_count
-- FROM orders
-- GROUP BY date
-- ORDER BY date DESC;

-- 12. Business Problem: The restaurant management wants to identify pizzas whose total quantity
-- sold is higher than the average quantity sold across all pizzas.
-- Task: Write a SQL query using a CTE to calculate the total quantity sold for each pizza and display only those pizzas 
-- whose quantity sold is greater than the average quantity sold.

-- WITH pizza_sales 
-- AS(SELECT pizza_id , SUM(quantity) AS Total_quantity FROM order_details GROUP BY pizza_id)

-- SELECT 
-- 		pizza_id,
-- 		Total_quantity 
-- FROM pizza_sales 
-- WHERE Total_quantity > (SELECT AVG(quantity) FROM order_details);

-- ## Other soloution

-- with pizza_sales as(
-- select pizza_id , sum(quantity) as Total_quantity
-- from order_details group by pizza_id),

-- avg_sales as(
-- select avg(Total_quantity) as Average_quantity from pizza_sales)
-- select pizza_id, Total_quantity from pizza_sales join avg_sales  on pizza_sales.total_quantity>avg_sales.Average_quantity;

-- -- 13. Business Problem: The business wants to identify pizzas that are priced higher than the average pizza price.
-- -- Task: Write a SQL query using a subquery to display pizza IDs, sizes, and prices of pizzas whose price is greater 
-- -- than the average pizza price.
-- SELECT 
--     pizza_id,
--     size,
--     price
-- FROM pizzas
-- WHERE price > (SELECT AVG(price)FROM pizzas);

-- -- 14. Business Problem: The management wants to rank pizzas based on total revenue generated so they can identify top-performing pizzas.
-- -- Task: Write a SQL query using a window function to rank pizzas based on total revenue generated.
-- select pizzas.pizza_id,
-- sum(quantity*price) as total_revenue,
-- rank() over(order by sum(quantity*price) desc) as revenue_rank
-- from order_details join pizzas
-- on order_details.pizza_id = pizzas.pizza_id
-- group by pizzas.pizza_id;
