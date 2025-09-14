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
