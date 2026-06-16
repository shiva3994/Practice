-- CTE - with clause - 

-- fetch empoyees whose salary is above the avg salary of all employees
-- While using with clause the with clause should come before the select command

WITH average_salary (avg_sal) AS
		(SELECT AVG(salary) FROM employee)
SELECT *
FROM employee e, average_salary av
WHERE e.salary > av.avg_sal;

---------------------------------------------------------------------------------

CREATE database sales_practice;

-- QUERY 2 :
create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);


insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

---------------------------------------------------------------------------------

-- Find total sales per each store
select s.store_id,
sum(s.cost) as total_sales_per_store
from sales s
group by s.store_id;

	
-- Find average sales with respect to all stores
select avg(total_sales_per_store) avg_sale_for_all_store
from (select s.store_id, sum(s.cost) as total_sales_per_store
	from sales s
	group by s.store_id) x;

-- Find stores who's sales where better than the average sales accross all stores
select *
from   (select s.store_id, sum(s.cost) as total_sales_per_store
				from sales s
				group by s.store_id
	   ) total_sales
join   (select avg(total_sales_per_store) as avg_sale_for_all_store
				from (select s.store_id, sum(s.cost) as total_sales_per_store
		  	  		from sales s
			  			group by s.store_id) x
	   ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;


-- Using WITH clause
WITH total_sales as
		(select s.store_id, sum(s.cost) as total_sales_per_store
		from sales s
		group by s.store_id),
	avg_sales as
		(select avg(total_sales_per_store) as avg_sale_for_all_store
		from total_sales)
select *
from   total_sales
join   avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;
