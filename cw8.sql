USE AdventureWorks2022;
USE AdventureWorksLT2022;
--1
WITH exp1 (FirstName, LastName, Rate)
AS
(
    SELECT FirstName, LastName, Rate
    FROM AdventureWorks2022.Person.Person AS person
    INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory AS pay
    ON person.BusinessEntityID = pay.BusinessEntityID
)
SELECT *
INTO #TempEmployeeInfo
FROM exp1;

SELECT * FROM #TempEmployeeInfo;

--2
SELECT *FROM SalesLT.SalesOrderHeader;

WITH exp2 (CompanyContact, Revenue)
AS
(
	SELECT concat(CompanyName, ' (', FirstName, ' ', LastName, ')') AS CompanyContact, TotalDue AS Revenue 
	FROM AdventureWorksLT2022.SalesLT.Customer AS customer
	INNER JOIN AdventureWorksLT2022.SalesLT.SalesOrderHeader AS header
	ON customer.CustomerID = header.CustomerID
)
SELECT * FROM exp2
ORDER BY CompanyContact;

--3
WITH exp3 (Category, SalesValue) AS
(
    SELECT kat.Name AS Category, ROUND(LineTotal, 2) AS SalesValue
    FROM AdventureWorksLT2022.SalesLT.Product AS produkt
    INNER JOIN AdventureWorksLT2022.SalesLT.ProductCategory AS kat
        ON produkt.ProductCategoryID = kat.ProductCategoryID
    INNER JOIN AdventureWorksLT2022.SalesLT.SalesOrderDetail AS detail
        ON produkt.ProductID = detail.ProductID
)
SELECT Category, CAST(ROUND(SUM(SalesValue), 2) AS DECIMAL(10, 2)) AS SalesValue
FROM exp3
GROUP BY Category
ORDER BY Category;


