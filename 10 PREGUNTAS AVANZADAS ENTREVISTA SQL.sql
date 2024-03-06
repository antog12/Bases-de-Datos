--use AdventureWorks2019

--10 PREGUNTAS SQL AVANZADAS DE ENTREVISTA--

--Question: Retrieve the top 5 highest paid employees for each
--department, sorted by salary in descending order.
select * from HumanResources.Employee

select * from HumanResources.vEmployeeDepartment


select Department,FirstName,VacationHours
from(
select ve.Department,ve.FirstName,e.VacationHours,
ROW_NUMBER() over (
partition by ve.department order by e.vacationHours desc) as rank
from HumanResources.vEmployeeDepartment ve
inner join HumanResources.Employee e
on e.BusinessEntityID=ve.BusinessEntityID) ranked
where rank <=5

---------------------------
----------------------------
------------------------------

select * from Sales.SalesOrderHeader


--total due
--order date

select DATEPART(MONTH,OrderDate) as mes,
coalesce(SUM(TotalDue),0) as ventasTotales,
case 
	when DATEPART(MONTH,OrderDate) = 1 then 'enero'
	when DATEPART(MONTH,OrderDate) = 2 then 'febrero'
	when DATEPART(MONTH,OrderDate) = 3 then 'marzo'
	when DATEPART(MONTH,OrderDate) = 4 then 'abril'
	when DATEPART(MONTH,OrderDate) = 5 then 'mayo'
	when DATEPART(MONTH,OrderDate) = 6 then 'junio'
	when DATEPART(MONTH,OrderDate) = 7 then 'julio'
	when DATEPART(MONTH,OrderDate) = 8 then 'agosto'
	when DATEPART(MONTH,OrderDate) = 9 then 'septiembre'
	when DATEPART(MONTH,OrderDate) = 10 then 'octubre'
	when DATEPART(MONTH,OrderDate) = 11 then 'noviembre'
	when DATEPART(MONTH,OrderDate) = 12 then 'diciembre'
	else 'EL mes no existe'
end as MesTexto
from Sales.SalesOrderHeader
where DATEPART(YEAR,OrderDate) ='2013'
group by DATEPART(MONTH,OrderDate)
order by DATEPART(MONTH,OrderDate) asc

-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
--Question: Find customers who have made a purchase every
--month for the last six months.
select * from Purchasing.PurchaseOrderHeader
select distinct VendorID from Purchasing.PurchaseOrderHeader

select VendorID
from Purchasing.PurchaseOrderHeader
where
DATEpart(MONTH,OrderDate) -6 <=all(--aqui deberia ser la fecha actual
select DATEpart(MONTH,OrderDate)
from Purchasing.PurchaseOrderHeader
where Purchasing.PurchaseOrderHeader.VendorID = Purchasing.PurchaseOrderHeader.VendorID)
-------------------
---------------------
-------------------------
--Question: Calculate the running total of sales for each day
--within the past month.

select * from Sales.SalesOrderHeader

select OrderDate, SUM(TotalDue) over (
order by orderdate ) as totalacumulado
from Sales.SalesOrderHeader

--otra forma
SELECT OrderDate,
       SUM(TotalDue) OVER (ORDER BY orderdate) AS [Total Acumulado]
FROM Sales.SalesOrderHeader
WHERE orderdate >= DATEADD(MONTH, -1, OrderDate)

-----------------------------
/*
Para calcular el total acumulado de ventas por cada día del mes anterior en SQL Server, puedes seguir una de las siguientes opciones:

    Generar los días del mes y unirlos a la consulta principal:
        Primero, generamos los días del mes utilizando una Common Table Expression (CTE).
        Luego, unimos esta tabla de días con tus datos de ventas para obtener los resultados del mes.
        Aquí tienes un ejemplo de cómo hacerlo:

*/
--DECLARE @mes TINYINT = 8;
--DECLARE @ano INT = 2017;

--WITH CTE_DIAS AS (
--    SELECT DATEADD(MONTH, @mes - 1, DATEADD(YEAR, @ano, 0)) AS D
--    UNION ALL
--    SELECT DATEADD(DAY, 1, D)
--    FROM CTE_DIAS
--    WHERE D < DATEADD(MONTH, @mes, DATEADD(YEAR, @ano, 0)) - 1
--)

--SELECT DATEPART(DAY, c.D) AS DIAS
--INTO #DT
--FROM CTE_DIAS c

--SELECT DATEPART(DAY, VMP.fechaPago) AS fecha, ISNULL(SUM(VMP.totalPago), 0) AS total
--INTO #VMP
--FROM VentasMatriculasPagos VMP
--WHERE VMP.estado = 1
--    AND YEAR(VMP.fechaPago) = @ano
--    AND MONTH(VMP.fechaPago) = @mes
--    AND VMP.idSede = 1
--GROUP BY DATEPART(DAY, VMP.fechaPago)

--SELECT D.DIAS, ISNULL(V.total, 0) AS TOTAL
--FROM #DT D
--LEFT JOIN #VMP V ON V.fecha = D.DIAS

--DROP TABLE #DT
--DROP TABLE #VMP

--------------------------
--------------------------
-----------------------------
--Question: L ist the products that have been sold in all cities
--where the company operates.

--mirar pregunta en el tema

-------------------------
------------------------
------------------------
--Question: Retrieve the top 10 customers who have spent the
--most on their single purchase

select * from Purchasing.Vendor
select * from Purchasing.PurchaseOrderHeader

select top 10 VendorID, max(TotalDue) as maxVendor
from Purchasing.PurchaseOrderHeader
group by VendorID
order by maxVendor desc

-------------------------
------------------------
------------------------

--Question: Find the employees who manage the same number
--of employees as their manager.

select * from HumanResources.Employee
select * from HumanResources.vEmployeeDepartment

--no tengo para comparar, mirar apuntes
-------------------------
------------------------
------------------------

select * from Sales.SalesOrderHeader
select * from Production.ProductListPriceHistory

select s1.SalesOrderID, s1.OrderDate,s1.TotalDue,
AVG(TotalDue) over ( partition by s1.SalesOrderID 
order by 
s1.OrderDate between datediff(day,) )
from Sales.SalesOrderHeader s1


select DATEDIFF(DAY,'2024-02-01',GETDATE()+1)

select distinct OrderDate
from Sales.SalesOrderHeader
order by OrderDate asc

select MAX(OrderDate)
from Sales.SalesOrderHeader

select DATEDIFF(DAY,MIN(OrderDate),MAX(OrderDate)-30)
from Sales.SalesOrderHeader


--1126
--1096

select DATEDIFF(DAY,min(OrderDate),MAX(OrderDate))
from Sales.SalesOrderHeader
group by OrderDate
order by OrderDate 

select top 30 OrderDate,SUM(TotalDue)
from Sales.SalesOrderHeader
group by TotalDue,OrderDate
order by OrderDate desc

SELECT SalesOrderID,OrderDate,TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate >= DATEADD(DAY, -30,'2014-06-30T00:00:00.000' )
ORDER BY OrderDate desc;

select DATEADD(DAY, -30, '2014-06-30T00:00:00.000')
 
 ------------------------------------
 -----------------------------------
 -------------------------------------
 --Pregunta: Lista los departamentos en los que el salario medio es
--superior al salario medio global de la empresa.

select * from Sales.SalesOrderHeader

select AVG(TotalDue)
from Sales.SalesOrderHeader
--lo vamos a hacer con la media de vacaciones
select * from Salarios
select * from HumanResources.Department
select * from HumanResources.Employee