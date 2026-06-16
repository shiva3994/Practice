CREATE TABLE employees (
emp_id INTEGER,
emp_name CHARACTER VARYING(50),
dept_name CHARACTER VARYING(50),
salary INTEGER
);

INSERT INTO employees (emp_id, emp_name, dept_name, salary) VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh', 'Finance', 5000),
(107, 'Preet', 'HR', 7000);

INSERT INTO employees (emp_id, emp_name, dept_name, salary) VALUES
(108, 'Sneha', 'Admin', 4500),
(109, 'Vikram', 'IT', 4800),
(110, 'Priya', 'Finance', 6200),
(111, 'Arjun', 'HR', 3200),
(112, 'Kiran', 'IT', 4600),
(113, 'Neha', 'Admin', 4100),
(114, 'Suresh', 'Finance', 5800),
(115, 'Anita', 'HR', 3400),
(116, 'Ravi', 'IT', 5000),
(117, 'Meera', 'Admin', 4300),
(118, 'Hari', 'Finance', 5900),
(119, 'Sunil', 'HR', 3600),
(120, 'Lakshmi', 'IT', 4700),
(121, 'Deepak', 'Admin', 4200),
(122, 'Shalini', 'Finance', 6300),
(123, 'Vijay', 'HR', 3800),
(124, 'Pooja', 'IT', 4900);

SELECT * FROM employees;

-- Max salary of employe
SELECT MAX(salary) AS max_salary
FROM employee;

-- MAX salary by each department
SELECT 
		dept_name,
		MAX(salary) AS max_salary
FROM employee
GROUP BY dept_name;

-- MAX salary with all the details of the table instead of just 1 and add the new column max salary for all rows by using over()
SELECT e.*,
MAX(salary) OVER() AS max_salary
FROM employee e;

-- MAX salary depat wise with all the details of the table instead of just 1 and add the new column max salary for all rows using over()
SELECT e.*,
MAX(salary) OVER(PARTITION BY dept_name) AS max_salary
FROM employee e;

-- Common function use specifically as windows functions

-- ROW_NUMBER() assignes unique value to the record in table
SELECT e.*,
ROW_NUMBER() OVER() AS rn -- we have used over with no specification so it will take entire tabel as window
FROM employee e;

SELECT e.*,
ROW_NUMBER() OVER(PARTITION BY dept_name) AS rn -- we have used over with specification of dept_name so it will put no. fr every dept seprtly
FROM employee e;

-- find first 2 employes who joined the each dep in company based on emp id

SELECT * FROM 
		(SELECT e.*, ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY emp_id) 
        AS rn FROM employee e) x
WHERE x.rn < 3;

-- RANK function 
-- fetch the top 3 employees in each department earning the max salary

SELECT e.*,
RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk
FROM employee e;

-- Emp only for salary in rank 1,2 ( top 2 ranking )

SELECT * FROM 
		(SELECT e.*, RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk
		FROM employee e) x
WHERE x.rnk < 3;

-- DENSE RANK -- repeate the rank for same values -- RANK WILL SKIP value -- DENSE RANK WILL NOT skip any value

SELECT e.*, 
		RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk, -- may give same rank on same colmn but it wil skip nxt rnk
		DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS dns_rnk, -- may give same rank on same colmn but wil nt skp nxt rnk
        ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn -- will give unique number for records regardless of reperetion
FROM employee e;

-- LAG -- 

SELECT e.*,
LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary
FROM employee e;

SELECT e.*,
LAG(salary, 2, 0) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary -- check salary of 2 emp prior 
FROM employee e;

-- LEAD -- 

SELECT e.*,
LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary, -- Check for salary for prevoious emp
LEAD(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary -- Check for salary for next emp
FROM employee e;

-- fetch query to display if the salary of an employe is higher, lower or equal to the previous emp

SELECT e.*,
LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary, 
CASE WHEN e.salary > LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) THEN 'HIGHER'
	 WHEN e.salary < LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) THEN 'LOWER'
	 WHEN e.salary = LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) THEN 'SAME'
	 END sal_range
FROM employee e;