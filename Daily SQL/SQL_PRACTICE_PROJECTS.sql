-- Q1: Orders with total value > 2000 (OrderID, OrderValue)

SELECT o.OrderID, SUM(od.Quantity * p.Price) AS OrderValue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING SUM(od.Quantity * p.Price) > 2000;

-- Q2: List all Customer Names

SELECT CustomerName
FROM Customers;

-- Q3: Number of orders handled by each employee (EmployeeID, OrderCount)

SELECT EmployeeID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY EmployeeID;

-- Q4: find the customer who placed the single largest order by value and output exactly three columns: CustomerName, OrderID, and TotalValue

WITH OrderTotals AS (
    SELECT 
        c.CustomerName, 
        o.OrderID, 
        SUM(od.Quantity * p.Price) AS TotalValue
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerName, o.OrderID
)
SELECT CustomerName, OrderID, TotalValue
FROM OrderTotals
ORDER BY TotalValue DESC
LIMIT 1;

-- Q5: Number of customers per country (Country, CustomerCount)

SELECT Country, COUNT(CustomerID) AS CustomerCount
FROM Customers
GROUP BY Country;

-- Q6: List all employee names (FirstName, LastName)

SELECT FirstName, LastName
FROM Employees;

-- Q7: Customer(s) with largest single order (CustomerName, OrderID, TotalValue)

WITH OrderTotals AS (
    SELECT c.CustomerName, o.OrderID, SUM(od.Quantity * p.Price) AS TotalValue
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerName, o.OrderID
)
SELECT CustomerName, OrderID, TotalValue
FROM OrderTotals
WHERE TotalValue = (SELECT MAX(TotalValue) FROM OrderTotals);

-- Q8: Products costing less than 15 (ProductName)

SELECT ProductName
FROM Products
WHERE Price < 15;

-- Q9: Products costing more than 50 (ProductName, Price)

SELECT ProductName, Price
FROM Products
WHERE Price > 50;

-- Q10: Orders from latest to oldest (OrderID, OrderDate)

SELECT OrderID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;

-- Q11: Products supplied by 'Exotic Liquid' (ProductName)

SELECT p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Exotic Liquid';

-- Q12: Average price per category (CategoryName, AvgPrice)

SELECT c.CategoryName, AVG(p.Price) AS AvgPrice
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

-- Q13: Products ordered more than 12 times (ProductName)

SELECT p.ProductName
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING COUNT(od.OrderID) > 12;

-- Q14: Customers starting with 'w' and employee names (CustomerName, FirstName, LastName)

SELECT c.CustomerName, e.FirstName, e.LastName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.CustomerName LIKE 'w%';

-- Q15: Top 3 most ordered products by quantity (ProductID, TotalOrdered)

SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;