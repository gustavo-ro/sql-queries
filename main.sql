-- AI Responses for multiple sql exercises
--Exercise Simple SQL Queries

--Question 1: Get all columns from the tables Customers, Orders and Suppliers
--Command:
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customers';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Suppliers';

--Question 2: sql command to Get all Customers alphabetically, by Country and name
--Command:
SELECT *
FROM dbo.Customers
ORDER BY Country ASC, CompanyName ASC;

--Question 3: Get all Orders by date
--Command:
SELECT *
FROM dbo.Orders
ORDER BY OrderDate ASC;

--Question 4: Get the count of all Orders made during 1997
--Command:
SELECT COUNT(*) AS OrdersCount
FROM dbo.Orders
WHERE YEAR(OrderDate) = 1997;

--Question 5: Get the names of all the contact persons where the person is a manager, alphabetically
--Command: 
SELECT ContactName
FROM dbo.Customers
WHERE ContactTitle LIKE '%Manager%'
ORDER BY ContactName ASC;

--Question 6: Get all orders placed on the 19th of May, 1997
--Command:
SELECT *
FROM dbo.Orders
WHERE OrderDate = '1997-05-19';

--Exercise SQL Queries for JOINS

--Question 1: Create a report for all the orders of 1996 and their Customers
--Command:
SELECT o.OrderID, o.OrderDate, o.RequiredDate, o.ShippedDate, o.Freight,
       c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle, c.Country
FROM dbo.Orders o
INNER JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1996
ORDER BY o.OrderDate ASC;

--Question 2: Create a report that shows the number of employees and customers from each city that has employees in it
--Command:
SELECT e.City,
       COUNT(DISTINCT e.EmployeeID) AS EmployeeCount,
       COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM dbo.Employees e
LEFT JOIN dbo.Customers c ON e.City = c.City
GROUP BY e.City
ORDER BY e.City ASC;

--Question 3: Create a report that shows the number of employees and customers from each city that has customers in it
--Command:
SELECT c.City,
       COUNT(DISTINCT e.EmployeeID) AS EmployeeCount,
       COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM dbo.Customers c
LEFT JOIN dbo.Employees e ON c.City = e.City
GROUP BY c.City
ORDER BY c.City ASC;

--Question 4: Create a report that shows the number of employees and customers from each city
--Command:
SELECT city,
       COUNT(DISTINCT EmployeeID) AS EmployeeCount,
       COUNT(DISTINCT CustomerID) AS CustomerCount
FROM (
    SELECT City, EmployeeID, NULL AS CustomerID FROM dbo.Employees
    UNION ALL
    SELECT City, NULL AS EmployeeID, CustomerID FROM dbo.Customers
) AS combined
GROUP BY city
ORDER BY city ASC;

--Exercise SQL Queries for HAVING

--Question 1: Create a report that shows the order ids and the associated employee names for orders that shipped after the required date
--Command:
SELECT o.OrderID, e.FirstName, e.LastName
FROM dbo.Orders o
INNER JOIN dbo.Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.ShippedDate > o.RequiredDate;

--Question 2: Create a report that shows the total quantity of products (from the Order_Details table) ordered. Only show records for products for which the quantity ordered is fewer than 200
--Command:
SELECT ProductID, SUM(Quantity) AS TotalQuantityOrdered
FROM dbo.[Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) < 200
ORDER BY ProductID ASC;

--Question 3: Create a report that shows the total number of orders by Customer since December 31, 1996. The report should only return rows for which the total number of orders is greater than 15
--Command:
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM dbo.Orders
WHERE OrderDate > '1996-12-31'
GROUP BY CustomerID
HAVING COUNT(*) > 15
ORDER BY TotalOrders DESC;

--Exercise SQL Inserting Records

--Question 1: Insert yourself into the Employees table Include the following fields: LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo (HINT: Use transactions)
--Command:
BEGIN TRANSACTION;
INSERT INTO dbo.Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo)
VALUES ('Copilot', 'GitHub', 'AI Assistant', 'Mr.', '1990-01-01', '2025-09-06', 'Redmond', 'WA', '98052', 'USA', '123-456-7890', NULL);
COMMIT TRANSACTION;

--Question 2: Insert an order for yourself in the Orders table Include the following fields: CustomerID, EmployeeID, OrderDate, RequiredDate (HINT: Use transactions)
--Command SQL:
BEGIN TRANSACTION;
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, RequiredDate)
VALUES ('ALFKI', 10, '2025-09-06T00:00:00', '2025-09-13T00:00:00');
COMMIT TRANSACTION;

--Question 3: Insert order details in the Order_Details table Include the following fields: OrderID, ProductID, UnitPrice, Quantity, Discount (hint: use transactions)
--Command:
BEGIN TRANSACTION;
INSERT INTO dbo.[Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11079, 1, 18.00, 5, 0.0);
COMMIT TRANSACTION;

--Exercise SQL Updating Records

--Question 1: sql command to Update the phone of yourself (from the previous entry in Employees table) (hint: use transactions)
--Command:
BEGIN TRANSACTION;
UPDATE dbo.Employees
SET HomePhone = '987-654-3210'
WHERE LastName = 'Copilot' AND FirstName = 'GitHub';
COMMIT TRANSACTION;

--Question 2: sql command to Double the quantity of the order details record you inserted before (hint: use transactions)
--Command:
BEGIN TRANSACTION;
UPDATE dbo.[Order Details]
SET Quantity = Quantity * 2
WHERE OrderID = 11079 AND ProductID = 1;
COMMIT TRANSACTION;

--Question 3: sql command to Repeat previous update but this time update all orders associated with you (hint: use transactions)
--Command:
BEGIN TRANSACTION;
UPDATE dbo.[Order Details]
SET Quantity = Quantity * 2
WHERE OrderID IN (
    SELECT OrderID FROM dbo.Orders WHERE EmployeeID = 10
);
COMMIT TRANSACTION;

--Exercise SQL Deleting Records

--Question 1: Delete the records you inserted before. Don't delete any other records! (hint: use transactions)
--Command:
BEGIN TRANSACTION;
DELETE FROM dbo.[Order Details]
WHERE OrderID = 11079 AND ProductID = 1;
COMMIT TRANSACTION;
BEGIN TRANSACTION;
DELETE FROM dbo.Orders
WHERE OrderID = 11079;
COMMIT TRANSACTION;
BEGIN TRANSACTION;
DELETE FROM dbo.Employees
WHERE LastName = 'Copilot' AND FirstName = 'GitHub';
COMMIT TRANSACTION;
