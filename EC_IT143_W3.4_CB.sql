/*
====================================================================
Script Name: EC_IT143_W3.4_CB.sql
Author: Carlos Braga
Date: [Enter Today's Date]
Purpose: Answers to 8 AdventureWorks questions selected from classmates.
====================================================================
*/

-- ==================================================================
-- Q1 (Marginal) - Author: John Allotey
-- Question: What are the ten most expensive products based on their list prices?
-- ==================================================================
SELECT TOP 10 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- ==================================================================
-- Q2 (Marginal) - Author: Carlos Braga (My own question)
-- Question: How many active employees work in the Sales department?
-- ==================================================================
SELECT COUNT(BusinessEntityID) AS ActiveSalesEmployees
FROM HumanResources.Employee
WHERE DepartmentID = 3 AND CurrentFlag = 1; -- Note: DepartmentID 3 is typically Sales

-- ==================================================================
-- Q3 (Moderate) - Author: Carlos Ruiz
-- Question: Which customers placed the most orders? How much did they spend in total?
-- ==================================================================
SELECT TOP 5 
    c.CustomerID, 
    p.FirstName + ' ' + p.LastName AS CustomerName,
    COUNT(soh.SalesOrderID) AS TotalOrders,
    SUM(soh.TotalDue) AS TotalSpent
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY TotalSpent DESC;

-- ==================================================================
-- Q4 (Moderate) - Author: Jose Valderrama Almanza
-- Question: Which products have the highest sales quantities, and what categories do they belong to?
-- ==================================================================
SELECT TOP 5
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name
ORDER BY TotalQuantitySold DESC;

-- ==================================================================
-- Q5 (Increased) - Author: Carlos Braga (My own question)
-- Question: For the year 2011, calculate total sales revenue per salesperson, 
-- including full name, job title, sales quota, and actual revenue. Sort highest to lowest.
-- ==================================================================
SELECT 
    p.FirstName + ' ' + p.LastName AS SalesPersonName,
    e.JobTitle,
    sp.SalesQuota,
    SUM(soh.TotalDue) AS ActualRevenue
FROM Sales.SalesPerson sp
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
WHERE YEAR(soh.OrderDate) = 2011
GROUP BY p.FirstName, p.LastName, e.JobTitle, sp.SalesQuota
ORDER BY ActualRevenue DESC;

-- ==================================================================
-- Q6 (Increased) - Author: Elie flaurice DIEUDONNE
-- Question: Prepare a monthly sales report for the Bikes category in 2013. 
-- Include the product subcategory, total quantity sold, and total sales amount for each month.
-- ==================================================================
SELECT 
    MONTH(soh.OrderDate) AS OrderMonth,
    psc.Name AS Subcategory,
    SUM(sod.OrderQty) AS TotalQuantity,
    SUM(sod.LineTotal) AS TotalSalesAmount
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes' AND YEAR(soh.OrderDate) = 2013
GROUP BY MONTH(soh.OrderDate), psc.Name
ORDER BY OrderMonth, Subcategory;

-- ==================================================================
-- Q7 (Metadata) - Author: John Allotey
-- Question: Using the INFORMATION_SCHEMA.COLUMNS view, which tables have a column named ProductID, 
-- and which database schemas do they belong to?
-- ==================================================================
SELECT 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductID'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- ==================================================================
-- Q8 (Metadata) - Author: Dmytro Ivanytskyi
-- Question: Generate a list of all base tables that belong to the 'HumanResources' schema using system views.
-- ==================================================================
SELECT 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'HumanResources' 
AND TABLE_TYPE = 'BASE TABLE';