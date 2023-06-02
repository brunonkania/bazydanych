USE AdventureWorks2022;

--1
CREATE FUNCTION cw7.generatefibonacci (@n INT)
RETURNS @fib TABLE(
		liczba INT
		)
AS
BEGIN
	DECLARE
		@f1 INT =0,
		@f2 INT =1,
		@i INT =2,
		@f3 INT;
	INSERT INTO @fib
	VALUES
		(@f1),
		(@f2);
	WHILE @i<=@n
		BEGIN
			SET @f3=@f1+@f2;
			SET @f1=@f2;
			SET @f2=@f3;
			SET @i=@i+1;
			INSERT INTO @fib
			VALUES (@f3);
		END;
	RETURN;
END;

ALTER PROCEDURE cw7.fibonacci (@n INT)
AS
BEGIN
	SELECT * FROM cw7.generatefibonacci(@n);
END;

GO
EXEC cw7.fibonacci 15;
--2
CREATE TRIGGER Person.upper_surname
ON Person.Person
AFTER INSERT
AS
BEGIN
	WITH CTE
	AS
	(
		SELECT TOP(1) *
		FROM
			Person.Person
		ORDER BY
			BusinessEntityID DESC
	)
	UPDATE TOP(1) CTE
	SET 
		LastName=UPPER(LastName);
END;


INSERT INTO
	Person.BusinessEntity(rowguid)
VALUES
	(NEWID());

SELECT *
FROM
	Person.BusinessEntity
ORDER BY
	BusinessEntityID DESC;
	
DROP TRIGGER Person.upper_surname

INSERT INTO 
	Person.Person (BusinessEntityID, PersonType, FirstName, LastName)
VALUES 
	(20780, 'IN', 'TRZECIA PROBA', 'baab');

SELECT * 
FROM 
	Person.Person
ORDER BY
	BusinessEntityID DESC;

SELECT * INTO Person.PersonCopy FROM Person.PersonCopy


--3

CREATE TRIGGER Sales.taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE
		@oldTax SMALLMONEY,
		@newTax SMALLMONEY;
	SELECT @oldTax=TaxRate FROM deleted;
	SELECT @newTax=TaxRate FROM inserted;
	IF @newTax>(1.3*@oldTax) OR @newTax<(0.7*@oldTax)
		RAISERROR('ZA DUZA ZMIANA', 10, 1);
END;
GO


CREATE TRIGGER Sales.taxRateMonitoring2
ON Sales.SalesTaxRate
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE
		@oldTax SMALLMONEY,
		@newTax SMALLMONEY;
	SELECT @oldTax=TaxRate FROM deleted;
	SELECT @newTax=TaxRate FROM inserted;
	IF @newTax<(1.3*@oldTax) AND @newTax>(0.7*@oldTax)
		BEGIN
			(SELECT * 
			INTO temporary
			FROM inserted)
			UNION
			(SELECT * FROM Sales.SalesTaxRate
			EXCEPT
			SELECT * FROM deleted)

			UPDATE Sales.SalesTaxRate
			SET
				TaxRate=temp.TaxRate
			FROM
				Sales.SalesTaxRate tax,
				temporary temp
			WHERE
				tax.SalesTaxRateID=temp.SalesTaxRateID;
			
			DROP TABLE temporary;
		END;
	ELSE
		BEGIN
			RAISERROR('ZA DUZA ZMIANA', 11, 2);
		END;
END;
GO

DROP TRIGGER Sales.taxRateMonitoring;

UPDATE Sales.SalesTaxRate
SET TaxRate=12
WHERE SalesTaxRateID=1;

