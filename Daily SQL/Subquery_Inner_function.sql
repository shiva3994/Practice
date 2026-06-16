-- =============================================================
-- MySQL Database Creation and Table Setup Script
-- =============================================================
-- WARNING:
-- This script assumes you are connected with a user that has
-- privileges to drop/create databases and tables.

-- DROP AND CREATE DATABASE
DROP DATABASE IF EXISTS `sales`;
CREATE DATABASE `sales` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sales`;

-- ======================================================
-- Table: customers
-- ======================================================

CREATE TABLE `customers` (
  `customerid` INT NOT NULL PRIMARY KEY,
  `firstname` VARCHAR(50),
  `lastname` VARCHAR(50),
  `country` VARCHAR(50),
  `score` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `customers` (`customerid`,`firstname`,`lastname`,`country`,`score`) VALUES
  (1, 'Jossef', 'Goldberg', 'Germany', 350),
  (2, 'Kevin', 'Brown', 'USA', 900),
  (3, 'Mary', NULL, 'USA', 750),
  (4, 'Mark', 'Schwarz', 'Germany', 500),
  (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: employees
-- ======================================================

CREATE TABLE `employees` (
  `employeeid` INT NOT NULL PRIMARY KEY,
  `firstname` VARCHAR(50),
  `lastname` VARCHAR(50),
  `department` VARCHAR(50),
  `birthdate` DATE,
  `gender` CHAR(1),
  `salary` INT,
  `managerid` INT,
  INDEX (`managerid`),
  CONSTRAINT `fk_employees_manager`
    FOREIGN KEY (`managerid`)
    REFERENCES `employees` (`employeeid`)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `employees` (`employeeid`,`firstname`,`lastname`,`department`,`birthdate`,`gender`,`salary`,`managerid`) VALUES
  (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
  (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
  (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
  (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
  (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

-- ======================================================
-- Table: products
-- ======================================================

CREATE TABLE `products` (
  `productid` INT NOT NULL PRIMARY KEY,
  `product` VARCHAR(50),
  `category` VARCHAR(50),
  `price` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `products` (`productid`,`product`,`category`,`price`) VALUES
  (101, 'Bottle', 'Accessories', 10),
  (102, 'Tire', 'Accessories', 15),
  (103, 'Socks', 'Clothing', 20),
  (104, 'Caps', 'Clothing', 25),
  (105, 'Gloves', 'Clothing', 30);

-- ======================================================
-- Table: orders
-- ======================================================

CREATE TABLE `orders` (
  `orderid` INT NOT NULL PRIMARY KEY,
  `productid` INT,
  `customerid` INT,
  `salespersonid` INT,
  `orderdate` DATE,
  `shipdate` DATE,
  `orderstatus` VARCHAR(50),
  `shipaddress` VARCHAR(255),
  `billaddress` VARCHAR(255),
  `quantity` INT,
  `sales` INT,
  `creationtime` TIMESTAMP,
  INDEX (`productid`),
  INDEX (`customerid`),
  INDEX (`salespersonid`),
  CONSTRAINT `fk_orders_product`
    FOREIGN KEY (`productid`)
    REFERENCES `products` (`productid`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customerid`)
    REFERENCES `customers` (`customerid`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_orders_employee`
    FOREIGN KEY (`salespersonid`)
    REFERENCES `employees` (`employeeid`)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `orders` (
  `orderid`,`productid`,`customerid`,`salespersonid`,
  `orderdate`,`shipdate`,`orderstatus`,`shipaddress`,
  `billaddress`,`quantity`,`sales`,`creationtime`
) VALUES
  (1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '2025-01-01 12:34:56'),
  (2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '2025-01-05 23:22:04'),
  (3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '2025-01-10 18:24:08'),
  (4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', '', 2, 60, '2025-01-20 05:50:33'),
  (5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2025-02-01 14:02:41'),
  (6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2025-02-06 15:34:57'),
  (7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', '', 2, 30, '2025-02-16 06:22:01'),
  (8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2025-02-18 10:45:22'),
  (9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', '', 2, 20, '2025-03-10 12:59:04'),
  (10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 23:25:15');

-- ======================================================
-- Table: orders_archive
-- ======================================================

CREATE TABLE `orders_archive` (
  `orderid` INT,
  `productid` INT,
  `customerid` INT,
  `salespersonid` INT,
  `orderdate` DATE,
  `shipdate` DATE,
  `orderstatus` VARCHAR(50),
  `shipaddress` VARCHAR(255),
  `billaddress` VARCHAR(255),
  `quantity` INT,
  `sales` INT,
  `creationtime` TIMESTAMP,
  INDEX (`productid`),
  INDEX (`customerid`),
  INDEX (`salespersonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `orders_archive` (
  `orderid`,`productid`,`customerid`,`salespersonid`,
  `orderdate`,`shipdate`,`orderstatus`,`shipaddress`,
  `billaddress`,`quantity`,`sales`,`creationtime`
) VALUES
  (1, 101, 2, 3, '2024-04-01', '2024-04-05', 'Shipped', '123 Main St', '456 Billing St', 1, 10, '2024-04-01 12:34:56'),
  (2, 102, 3, 3, '2024-04-05', '2024-04-10', 'Shipped', '456 Elm St', '789 Billing St', 1, 15, '2024-04-05 23:22:04'),
  (3, 101, 1, 4, '2024-04-10', '2024-04-25', 'Shipped', '789 Maple St', '789 Maple St', 2, 20, '2024-04-10 18:24:08'),
  (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Shipped', '987 Victory Lane', '', 2, 60, '2024-04-20 05:50:33'),
  (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Delivered', '987 Victory Lane', '', 2, 60, '2024-04-20 14:50:33'),
  (5, 104, 2, 5, '2024-05-01', '2024-05-05', 'Shipped', '345 Oak St', '678 Pine St', 1, 25, '2024-05-01 14:02:41'),
  (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', NULL, 2, 50, '2024-05-06 15:34:57'),
  (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-07 13:22:05'),
  (6, 101, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-12 20:36:55'),
  (7, 102, 3, 5, '2024-06-15', '2024-06-20', 'Shipped', '111 Main St', '222 Billing St', 0, 60, '2024-06-16 23:25:15');
  

-- ======================================================
-- Practice
-- ======================================================

-- sub query or inner query

CREATE DATABASE subquery_practice;

SELECT * FROM customer;
SELECT * FROM payment;

-- Find the avg value
SELECT AVG(amount) FROM payment;

-- Filter the customer date > avg value
SELECT * FROM payment
WHERE amount > 48; -- this is not dynamic

-- Sub query
SELECT * FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);

-- Use of in operator --
-- find custid amount and mode of paymnet of common cudtomers in paymnet and customers
SELECT customer_id, amount, mode
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer);

-- Exist funstion 
SELECT first_name, last_name
FROM customer c
WHERE EXISTS( 	SELECT customer_id, amount
				FROM payment p
                WHERE p.customer_id = c.customer_id
				AND amount > 50);
                
-- 
SELECT * FROM dept;
SELECT * FROM emp;

-- emp batao jaha deptid 30 hai

SELECT * FROM emp WHERE deptno = 30; -- deptid 30 jo ki sales hai uska data dikhao
SELECT deptno FROM dept	WHERE dname = 'sales'; -- sales ka jo deptno hai vo select karo

SELECT * FROM emp
WHERE deptno = ( 	SELECT deptno 
					FROM dept 
					WHERE dname = 'sales'); -- pehle andar vale query execute hoga fir bahar vala hoga
											-- ge ayah pehle sales ka dep number liya gaya
                                            -- fir emp table se us dept no ka data nikalagaya
                                            
SELECT * FROM emp
WHERE deptno IN ( 	SELECT deptno 
					FROM dept 
					WHERE dname = 'SALES' OR 'accounting')ORDER BY ename ASC;
                    
-- name of emp who earn more than there manager

SELECT ename, sal
FROM emp e
WHERE SAL > (	SELECT sal
				FROM emp m
                WHERE e.mgr = m.empno);
                
-- find second highest salary

SELECT MAX(sal) FROM emp
WHERE sal < (SELECT MAX(sal) FROM emp);

-- in case you wish to find as per the cell reference

SELECT DISTINCT sal 
FROM (
    SELECT sal, DENSE_RANK() OVER (ORDER BY sal DESC) AS R 
    FROM emp
) AS temp 
WHERE R = 15;

-- Employees with manager

SELECT ename, 
(SELECT ename FROM emp m WHERE e.mgr = m.empno) 
FROM emp e;

-- Emp with salary above above salary

SELECT ename, sal, (SELECT AVG(sal) FROM emp)
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY ename;

-- ======================================================
-- SELECT TABLE ORDERS FROM DB SALES
-- ======================================================

SELECT *
FROM SALES.ORDERS;

-- ======================================================
-- AVG OF SALES -- RESULT IS SCALER QUERY
-- ======================================================

SELECT
AVG(SALES) AS AVG_SALES
FROM SALES.ORDERS;

-- ======================================================
-- FIND CUSTOMERS ID -- RESULT IS ROW QUERY
-- ======================================================

SELECT
ORDERID,
ORDERSTATUS,
CUSTOMERID
FROM SALES.ORDERS;

-- ======================================================
-- FIND PRODUCTS WITH PRICE HIGHERT THAN AVG
-- ======================================================

-- MAIN QUERY

SELECT *
FROM -- SUBQUERY --
		(SELECT 
		PRODUCTID,
		PRICE,
		AVG(PRICE) OVER() AVGPRICE
		FROM PRODUCTS) T
WHERE PRICE > AVGPRICE;

-- ======================================================
-- RANK CUSTOMERS BASE ON TOTAL AMOUNT OF SALES
-- ======================================================

-- MAIN QUERY

SELECT *, RANK() OVER(ORDER BY TOTALSALES DESC) AS CUSTRANK
FROM -- SUBQUERY --
		(SELECT
		CUSTOMERID,
		SUM(SALES) AS TOTALSALES
		FROM SALES.ORDERS
		GROUP BY CUSTOMERID)T;
        
-- ======================================================
-- SHOW PRODUCT ID, PRODUCT NAMES, PRICES AND THE TOTAL NUMBER OF ORDERS
-- ======================================================

-- MAIN QUERY

SELECT 
PRODUCTID,
PRODUCT,
PRICE,
-- SUBQUERY
(SELECT COUNT(*) FROM SALES.ORDERS) AS TOTALORDERS
FROM SALES.PRODUCTS; -- MAIN QUERY

-- ======================================================
-- SHOW ALL CUSTOMER DETAILS AND FIND TOTAL ORDERS OF EACH CUSTOMER
-- ======================================================

SELECT -- MAIN QUERY
c.*,
o.TOTALORDERS
FROM SALES.CUSTOMERS c 
LEFT JOIN (	SELECT 
			CUSTOMERID,
			COUNT(*) TOTALORDERS
			FROM SALES.ORDERS
			GROUP BY CUSTOMERID) o -- SUBQUERY
ON c.CUSTOMERID = o.CUSTOMERID;

-- ======================================================
-- SHOW PRODUCTS THAT HAVE HIGHER PRICE THAN THE AVG PRICE OF THE AVG PRICE OF ALL PRODUCTS
-- ======================================================

SELECT -- MAIN QUERY
PRODUCTID,
PRICE,
( SELECT AVG(PRICE) AS AVGPRICE FROM SALES.PRODUCTS) AS AVGPRICE
FROM SALES.PRODUCTS
WHERE PRICE > ( SELECT -- SUBQUERY
				AVG(PRICE) AS AVGPRICE
				FROM SALES.PRODUCTS);

-- ======================================================
-- SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS IN GERMANY
-- ======================================================

SELECT * -- MAIN QUERY
FROM SALES.ORDERS
WHERE CUSTOMERID IN (SELECT  -- SUBQUERY
					 CUSTOMERID
					 FROM SALES.CUSTOMERS
					 WHERE COUNTRY = 'GERMANY');

-- ======================================================
-- SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS NOT IN GERMANY
-- ======================================================

SELECT * -- MAIN QUERY
FROM SALES.ORDERS
WHERE CUSTOMERID NOT IN (SELECT  -- SUBQUERY
					 CUSTOMERID
					 FROM SALES.CUSTOMERS
					 WHERE COUNTRY = 'GERMANY');
                     
-- ======================================================
-- FIND FEMALE EPLOYE WHOSE SALARY ARE GREATER THAN THE SALARY OF ANY MALE EMPLOYEE 
-- ======================================================

SELECT -- MAIN QUERY
		EMPLOYEEID,
		FIRSTNAME,
		GENDER,
		SALARY
FROM SALES.EMPLOYEES
WHERE GENDER = 'F'
AND SALARY > ANY (SELECT SALARY FROM SALES.EMPLOYEES WHERE GENDER = 'M'); -- SUBQUERY;

-- ======================================================
-- FIND FEMALE EPLOYE WHOSE SALARY ARE GREATER THAN THE SALARY OF ALL MALE EMPLOYEE 
-- ======================================================

SELECT -- MAIN QUERY
		EMPLOYEEID,
		FIRSTNAME,
		GENDER,
		SALARY
FROM SALES.EMPLOYEES
WHERE GENDER = 'F'
AND SALARY > ALL (SELECT SALARY FROM SALES.EMPLOYEES WHERE GENDER = 'M'); -- SUBQUERY;

-- ======================================================
-- SHOW ALL CUSTOMERS DETAILS AND FIND THE TOTAL ORDERS OF EACH CUSTOMERS
-- ======================================================

SELECT *,-- MAIN QUERY
(SELECT COUNT(*) FROM SALES.ORDERS o WHERE o.CUSTOMERID = C.CUSTOMERID) AS TOTALSALES -- SUBQUERY
FROM SALES.CUSTOMERS c;

-- ======================================================
-- SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS IN GERMANY
-- ======================================================

SELECT * -- MAIN QUERY
FROM SALES.ORDERS o
WHERE EXISTS (SELECT *  -- SUBQUERY
			  FROM SALES.CUSTOMERS c
			  WHERE COUNTRY = 'GERMANY'
			  AND o.CUSTOMERID = c.CUSTOMERID);
              
-- ======================================================
-- SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS NOT IN GERMANY
-- ======================================================

SELECT * -- MAIN QUERY
FROM SALES.ORDERS o
WHERE NOT EXISTS (SELECT *  -- SUBQUERY
			  FROM SALES.CUSTOMERS c
			  WHERE COUNTRY = 'GERMANY'
			  AND o.CUSTOMERID = c.CUSTOMERID);