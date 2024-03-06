use AdventureWorks2019

SELECT DISTINCT
  PRODUCT.ProductID,
  PRODUCT.Name
FROM Production.Product PRODUCT
INNER JOIN Sales.SalesOrderDetail DETAIL
ON PRODUCT.ProductID = DETAIL.ProductID
OR PRODUCT.rowguid = DETAIL.rowguid;



 
DECLARE @CPU INT; SET @CPU = @@CPU_BUSY
DECLARE @FECHA DATETIME; SET @FECHA = GETDATE();
DECLARE @TOTALREAD INT; SET @TOTALREAD = @@TOTAL_READ;
DECLARE @TOTALWRITE INT; SET @TOTALWRITE = @@TOTAL_WRITE;
 
 
DECLARE @TABLE TABLE (Literal varchar(100), value FLOAT)
 
-- La query
 
    SELECT DISTINCT
  PRODUCT.ProductID,
  PRODUCT.Name
FROM Production.Product PRODUCT
INNER JOIN Sales.SalesOrderDetail DETAIL
ON PRODUCT.ProductID = DETAIL.ProductID
OR PRODUCT.rowguid = DETAIL.rowguid; 
 
-- Fin de la query      
 
INSERT INTO @TABLE (Literal, value)
VALUES
( 'Resultados query',
   NULL),
( 'Tiempo uso Cpu:',
  (CONVERT(VarChar(50),((@@CPU_BUSY - @CPU) 
     * CAST(@@TIMETICKS AS FLOAT))))),
( 'Número de Lecturas:', 
  (CONVERT(VarChar(50),@@TOTAL_READ - @TOTALREAD))),
( 'Número de Escrituras:', 
  (CONVERT(VarChar(50),@@TOTAL_WRITE- @TOTALWRITE))),
( 'Tiempo Total en ms:', 
  (CONVERT(VarChar(50), 
    DATEDIFF(ms, @FECHA, GETDATE()))));
 
SELECT * FROM @TABLE