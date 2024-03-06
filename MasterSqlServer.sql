--USANDO LA BASE DE DATOS MASTER
USE master
GO

--CREANDO LA BASE DE DATOS MONROE
IF EXISTS(SELECT NAME FROM SYS.databases WHERE NAME='SaleOrder')
BEGIN
	DROP DATABASE SaleOrder
END
GO

CREATE DATABASE SaleOrder
GO

USE SaleOrder
GO


create table dbo.customer (
CustomerID int NOT null primary key,
CustomerFirstName varchar(50) NOT null,
CustomerLastName varchar(50) NOT null,
CustomerAddress varchar(50) NOT null,
CustomerSuburb varchar(50) null,
CustomerCity varchar(50) NOT null,
CustomerPostCode char(4) null,
CustomerPhoneNumber char(12) null,
);
create table dbo.inventory (
InventoryID tinyint NOT null primary key,
InventoryName varchar(50) NOT null,
InventoryDescription varchar(255) null,
);
create table dbo.employee (
EmployeeID tinyint NOT null primary key,
EmployeeFirstName varchar(50) NOT null,
EmployeeLastName varchar(50) NOT null,
EmployeeExtension char(4) null,
);
create table dbo.sale (
SaleID tinyint not null primary key,
CustomerID int not null references customer(CustomerID),
InventoryID tinyint not null references Inventory(InventoryID),
EmployeeID tinyint not null references Employee(EmployeeID),
SaleDate date not null,
SaleQuantity int not null,
SaleUnitPrice smallmoney not null
);



select * from customer
select * from inventory
select * from employee
select * from sale


---------------------
---------------------

select * from INFORMATION_SCHEMA.TABLES

--view specific row

select top 2 * from customer

select top 40 percent * from customer

--View specific column

select CustomerFirstName, CustomerLastName
from customer
order by CustomerLastName desc

select CustomerFirstName, CustomerLastName
from customer

select distinct CustomerLastName
from customer
order by CustomerLastName

--Save table to another table

select distinct CustomerLastName into temp
from customer
order by CustomerLastName

select * from temp

--Like (search something)

select * from
customer
where CustomerLastName like '__r%'

--In (search something)

select * from customer
where CustomerLastName in ('Borrie', 'Baron','Hars')

--> o <>

select * from customer
where CustomerLastName > 'Janney' or CustomerLastName > 'Riddel'

select * from customer
where CustomerLastName <> 'Janney' 
 --null y not null
select * from customer
where CustomerSuburb is null

select * from customer
where CustomerSuburb is not null


--Operadores

select * from sale
select * from employee

select * from sale
where SaleUnitPrice between 10000 and 30000

select COUNT(*) as numRegistros from customer
where CustomerFirstName like 'B%'

select COUNT(CustomerFirstName) as numRegistros from customer
where CustomerFirstName like 'B%'


select sale.EmployeeID, EmployeeFirstName, EmployeeLastName, COUNT(*) as [NumOrders], sum(SaleQuantity) as [Cantidadtotal]
from sale,employee
where sale.EmployeeID=employee.EmployeeID
group by sale.EmployeeID, EmployeeFirstName,EmployeeLastName


--count month


select MONTH(SaleDate) as [Month],  count(*) as [Number of Sales],
sum(SaleQuantity*SaleUnitPrice) as [Total Amount]
from sale
group by MONTH(SaleDate)

update sale
set SaleUnitPrice = CAST(SaleUnitPrice as numeric(10,2))

--max.,min avg

--Having

use Trabajote_5toB

select * from empleados

select titulo, count(titulo) as cantidad
from empleados
group by titulo
having COUNT(titulo)>1

select titulo, avg(ventas)
from empleados
group by titulo
having AVG(ventas)>150000
order by titulo, AVG(ventas)
----------------
----------------
use SaleOrder
select * from[HumanResources].[Employee]
select * from sale
select * from [dbo].[EmployeeDemographics]
select * from 
--case 

select FirstName, LastName, Age,
case
	when Age > 30 then 'Old'
	when Age between 27 and 30 then 'Young'
	else 'baby'
end
from EmployeeDemographics
where Age is not null
order by age


select * from [AdventureWorks2019].[HumanResources].[Employee] as e
select * from [SaleOrder].[dbo].[EmployeeDemographics] as ed



select ed.FirstName, ed.LastName, e.JobTitle, ed.Salary,
case
	when e.JobTitle = 'Design Engineer' then Salary + (Salary*.10)
	when e.JobTitle = 'Accountant' then Salary + (Salary*.05)
	when e.JobTitle = 'Buyer' then Salary + (Salary*.000001)
	else Salary + (Salary*.03)
end
	from [SaleOrder].[dbo].[EmployeeDemographics] as ed
join [AdventureWorks2019].[HumanResources].[Employee] as e
on ed.EmployeeID=e.BusinessEntityID

-------------------
---------------------


--totales de género
select ed.FirstName, ed.LastName, ed.Gender, ed.Salary,
count(ed.gender) over (partition by ed.gender) as TotalGender
from [SaleOrder].[dbo].[EmployeeDemographics] as ed
join [AdventureWorks2019].[HumanResources].[Employee] as e
on ed.EmployeeID=e.BusinessEntityID

--------------------
--Funciones STRING
--------------------

select BusinessEntityID, TRIM(BusinessEntityID) as IdTrim
from [AdventureWorks2019].[HumanResources].[Employee]

select BusinessEntityID, RTRIM(BusinessEntityID) as IdTrim
from [AdventureWorks2019].[HumanResources].[Employee]

select BusinessEntityID, LTRIM(BusinessEntityID) as IdTrim
from [AdventureWorks2019].[HumanResources].[Employee]

--replace

select JobTitle, REPLACE(JobTitle,'NULL','Desempleado') as jobfixed
from EmployeeDemographics

--substring
--de firstname desde la posiciín 1 sacamos 3 caracteres
select FirstName, SUBSTRING(FirstName,1,3) as nombreAbreviado
from EmployeeDemographics

-- UPPER and LOWER CASE
select FirstName, LOWER(FirstName)
from EmployeeDemographics

select FirstName, upper(FirstName)
from EmployeeDemographics

----------------------------------------
--procedimientos almacenados
----------------------------------------

select * from EmployeeDemographics
select * from [AdventureWorks2019].[HumanResources].[Employee]
---------------------------------------
---------------------------------------
create procedure Temp_Employee
@JobTitle nvarchar(100)
as
drop table if exists #temp_employee
create table temp_employee(
Jobtitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

insert into #temp_employee
select emp.JobTitle, count(emp.JobTitle),avg(dem.Age),avg(dem.Salary)
from EmployeeDemographics dem
join [AdventureWorks2019].[HumanResources].[Employee] emp
on dem.EmployeeID=emp.BusinessEntityID
where emp.JobTitle= @JobTitle
group by emp.JobTitle

select * from #temp_employee


Exec temp_employee 'Marketing Assistant'


---------------------
----------------------
--subqueries
------------------
-------------------

use SaleOrder
select * from EmployeeDemographics

select avg(Salary) from EmployeeDemographics

select EmployeeID,Salary,(select avg(Salary) from EmployeeDemographics) as allavgSalary,
'Salary Range'= CASE
					when Salary>3093.66
					then 'over media'
					else 'under media'
				END
from EmployeeDemographics
group by EmployeeID,Salary

--------------------
select  employeeID, Salary, AVG(salary) over () as allavgSalary
from EmployeeDemographics

select a.EmployeeID, AllavgSalary
from (select employeeID, Salary, AVG(salary) over () as allavgSalary
from EmployeeDemographics) a
order by employeeID

-----------------------------
select EmployeeId, JobTitle, Salary
from EmployeeDemographics
where EmployeeID in 
(select EmployeeID from EmployeeDemographics where Age>30)


select EmployeeID, JobTitle,Salary
from EmployeeDemographics
where Salary in
(select max(salary) from EmployeeDemographics)


--------------------------
--JOINS
--------------------------

select * from inventory
select * from sale

select * from inventory, sale
where inventory.inventoryId= sale.InventoryID

select inventoryname, saledate, saleunitprice ,SaleQuantity*SaleUnitPrice as TotalSales
from sale, inventory
where inventory.inventoryId= sale.InventoryID


select inventoryname, saledate, saleunitprice ,SaleQuantity*SaleUnitPrice as TotalSales
from sale, inventory
where inventory.inventoryId= sale.InventoryID
group by sale.InventoryID, InventoryName, SaleDate, SaleQuantity,SaleUnitPrice
order by InventoryName


select inventoryname, saledate, saleunitprice ,SaleQuantity*SaleUnitPrice as TotalSales
from inventory
inner join sale
on sale.InventoryID=inventory.InventoryID
order by InventoryName


select sale.InventoryID, inventoryname
from inventory
full outer join sale
on sale.InventoryID=inventory.InventoryID
where sale.InventoryID is NULL


select inventory.InventoryID, inventoryname
from inventory
left join sale
on sale.InventoryID=inventory.InventoryID


select inventory.InventoryID, inventoryname
from inventory
left join sale
on sale.InventoryID=inventory.InventoryID
where sale.InventoryID is null


-- without join: use subquery


select InventoryID, inventoryname
from inventory
where InventoryID not in (select InventoryID from sale)


select sale.InventoryID, inventoryname
from inventory
right join sale
on sale.InventoryID=inventory.InventoryID


-- self join

create table StaffTable(
employeeID int not null,
employeefirstname varchar(50),
employeelastname varchar(50),
managerID int
)

insert into StaffTable(employeeID,employeefirstname,employeelastname,managerID)
values (1001, 'Tan', 'Mei Ling', NULL)
insert into StaffTable(employeeID,employeefirstname,employeelastname,managerID)
values (1002, 'Kelvin', 'Koh', 1001)
insert into StaffTable(employeeID,employeefirstname,employeelastname,managerID)
values (1003, 'Amin', 'Wong', 1002)

select * from StaffTable

select e.employeeID, e.employeefirstname+ ' ' +e.employeelastname as [FullName],e.managerID,
m.employeefirstname+ ' ' +m.employeelastname as [ManagerName]

from StaffTable e
inner join StaffTable m
on e.managerID=m.employeeID

select e.employeeID, e.employeefirstname+ ' ' +e.employeelastname as [FullName],e.managerID,
m.employeefirstname+ ' ' +m.employeelastname as [ManagerName]

from StaffTable e
left outer join StaffTable m
on e.managerID=m.employeeID

-----------------
--SQL UNION
-----------------
--Permite combinar dos tablas (pero el número de columnas y
--los tipos de datos de cada columna deben coincidir).
--no necesita clave común, sólo atributos comunes
--Combinar, sin mostrar registros duplicados

select * from customer


select CustomerFirstName,CustomerLastName
from customer
union 
select CustomerFirstName,CustomerLastName
from customer


--fusiona, pero te muestra todo, incluso el registro duplicado

select CustomerFirstName,CustomerLastName
from customer
union all
select CustomerFirstName,CustomerLastName
from customer

--------------------------
--Intersect
---------------------------

--mantener sólo las filas comunes a ambas consultas
--no mostrar registros duplicados

select CustomerFirstName,CustomerLastName
from customer
intersect
select CustomerFirstName,CustomerLastName
from customer

-----------------
--Except
------------------
--generar sólo los registros que son únicos para
--la tabla CLIENTES

select CustomerFirstName,CustomerLastName
from customer
except
select CustomerFirstName,CustomerLastName
from customer


--------------------------------
--TABLAS Y VISTAS
--------------------------------

use SaleOrder

select * from customer
select * from inventory
select * from sale

create view CustomerView as
select CustomerFirstName+' '+CustomerLastName as [Customer Name],
CustomerPhoneNumber,
inventoryName, saleDate,SaleQuantity,SaleUnitPrice,SaleQuantity*SaleUnitPrice as [Total Amount]
from customer inner join sale on customer.CustomerID=sale.CustomerID
inner join inventory
on sale.InventoryID=inventory.InventoryID

select [Customer Name] from CustomerView


--crear tabla temporal

drop table if exists #temp_employee

create table #temp_employee(
JobTitle varchar(100),
EmployeesPerPerJob int,
AvgAge int,
AvgSalary int

)

insert into #temp_employee
select JobTitle, COUNT(Jobtitle),AVG(Age),AVG(Salary)
from EmployeeDemographics emp
group by JobTitle

select * from #temp_employee

--Duplicar una tabla

select CustomerFirstName+' '+CustomerLastName as [Customer Name],
CustomerPhoneNumber,
inventoryName, saleDate,SaleQuantity,SaleUnitPrice,SaleQuantity*SaleUnitPrice
as [Total Amount]into customerRec
from customer inner join sale on customer.customerid=sale.customerid inner join inventory
on sale.inventoryid=inventory.inventoryid
order by customerfirstname +' '+ customerlastname,inventoryname

select * from customerRec

--SQL Ranks--

select * from EmployeeDemographics

--row_number() si tienen salarios parecidos o iguales, podemos usaer este para rank()

select *,
		ROW_NUMBER() over (order by Salary desc) as SalaryRank
from EmployeeDemographics

--rank()

select *,
		RANK() over (Partition by Jobtitle order by Salary desc) as SalaryRank
from EmployeeDemographics
order by JobTitle, SalaryRank



select *,
		RANK() over (order by Salary desc) as SalaryRank
from EmployeeDemographics
order by SalaryRank

--dense_rank() obtiene el mismo ranking para rangos duplicados
--mantiene el rankin sin saltarselo. Con rank tenemos rankin 1,2,2,4
--con dense_rank, el ranking sería 1,2,2,3

insert into EmployeeDemographics(FirstName,LastName,Gender,HireDate,BirthDate,Salary,Age,JobTitle)
values('Anto','Abellan','Male','2023/11/21','1980/04/23',4997.06,43,'Salesman')

select *,
		DENSE_RANK() over (order by Salary desc) as SalaryRank
from EmployeeDemographics
order by SalaryRank

select max(EmployeeId) from EmployeeDemographics
--630 es el siguiente
select * from EmployeeDemographics

update EmployeeDemographics
set EmployeeID= 630
where FirstName= 'Anto'


--NTILE()--puede especificar cuántos grupos de resultados necesita, y los clasificará en consecuencia.

select *,
		NTILE(3) over (order by Salary desc) as SalaryRank
from EmployeeDemographics
order by SalaryRank


select *,
		NTILE(3) over (Partition by Jobtitle order by Salary desc) as SalaryRank
from EmployeeDemographics
order by JobTitle, SalaryRank


--ISNULL

select EmployeeID,FirstName,LastName,Gender,HireDate,BirthDate,Salary,Age,JobTitle
from EmployeeDemographics
where JobTitle is null

 -- split by delimiter--MUY importante esto para buscar texto

-- Substring,charindex y len(rango total del string)
--charindex me dice la posición de un valor, por ejemplo 9

use AdventureWorks2019

select LoginID, SUBSTRING(LoginID,1,9) as pruebaSubstring,
SUBSTRING(LoginID,1,CHARINDEX('\',LoginID)-1) as pruebaCharindex,
SUBSTRING(LoginID,CHARINDEX('\',LoginID)+1,len(LoginID)) as pruebaLen
from [HumanResources].[Employee]

select LEN(LoginId) from [HumanResources].[Employee]

select PARSENAME('[HumanResources].[Employee]',1) as Login

--REMOVER FILAS DUPLICADAS---

select * from [HumanResources].[Employee]

WITH RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
PARTITION BY BusinessEntityID,
JonTitle,
gender
ORDER BY UniqueID) 
as row_num
from [AdventureWorks2019].[HumanResources].[Employee]
)

--para borrar esos duplicados

--DELETE
Select * From RowNumCTE
Where row_num > 1
Order by PropertyAddress

--eliminar registros duplicados de una tabala en sql

use pruebas

drop table if exists dbo.empleados

create table empleados(
ID int identity primary key,
NOMBRE varchar(255),
APELLIDO varchar(255)

)
 insert into empleados(nombre, APELLIDO)
 values ('Maxi','Accoto')
 go 4

insert into empleados(nombre, APELLIDO)
 values ('Anto','Abellan')
 go 2

insert into empleados(nombre, APELLIDO)
 values ('Josemi','Gonzalez')
 go

select * from empleados

--BUSCAMOS REGISTROS DUPLICADOS

WITH C AS
(
select id, nombre, apellido,
ROW_NUMBER() over (partition by --particiona por los campos que yo creo que pueden ser duplicados
					nombre, apellido
					order by id) as duplicado
from empleados
)
select * from C--se selecciona todo
where duplicado > 1 --me traigo aquellos registros en los que nombre y apellido están más de una vez

--BORRAMOS LOS REGISTROS DUPLICADOS

WITH C AS
(
select id, nombre, apellido,
ROW_NUMBER() over (partition by --particiona por los campos que yo creo que pueden ser duplicados
					nombre, apellido
					order by id) as duplicado
from empleados
)
delete from C --hacemos el borrado de los registro duplicados
where duplicado>1

--VERIFICAMOS
select * from empleados






/*----------------------------------------------------------------------------------
110 SQL Query Interview Questions and Practice Exercises for Experienced and Fresher
*/----------------------------------------------------------------------------------

--Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
    (1, 'John', 'Doe', 'HR', 50000.00, '2020-01-15'),
    (2, 'Jane', 'Smith', 'Marketing', 55000.00, '2019-05-20'),
    (3, 'Mike', 'Johnson', 'IT', 60000.00, '2018-09-10'),
    (4, 'Emily', 'Williams', 'Finance', 58000.00, '2021-03-12'),
    (5, 'David', 'Lee', 'Operations', 52000.00, '2017-11-25');

----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

--Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    Country VARCHAR(50)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address, City, Country)
VALUES
    (1, 'Michael', 'Brown', 'michael@example.com', '123 Main St', 'New York', 'USA'),
    (2, 'Emma', 'Johnson', 'emma@example.com', '456 Elm St', 'Los Angeles', 'USA'),
    (3, 'Oliver', 'Smith', 'oliver@example.com', '789 Oak St', 'Chicago', 'USA'),
    (4, 'Sophia', 'Williams', 'sophia@example.com', '101 Maple Ave', 'Houston', 'USA'),
    (5, 'James', 'Lee', 'james@example.com', '222 Pine St', 'San Francisco', 'USA');

----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

--Orders table
drop table if exists dbo.orders

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    IsShipped BIT
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, IsShipped)
VALUES
    (1, 3, '2023-07-01', 100.00, 1),
    (2, 1, '2023-07-05', 250.00, 1),
    (3, 4, '2023-07-10', 180.00, 0),
    (4, 2, '2023-07-15', 300.00, 1),
    (5, 5, '2023-07-20', 120.00, 1);


--comprobamos

select * from Employees
select * from Customers
select * from Orders

use Pruebas

--1. Retrieve the top 3 highest-paid employees.

select top 3 * from Employees order by Salary desc

--2. Find the customers who have placed orders.

select c.CustomerID,c.FirstName,c.LastName
from Customers c
inner join Orders o
on c.CustomerID= o.CustomerID

--3. Show employees and their department names in alphabetical order.

select * from Employees
order by Department

--4. Find the customers who have placed orders for more than once.

select * from Customers
select * from Orders

select c.CustomerID,c.FirstName,c.LastName
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
group by c.CustomerID, c.FirstName, c.LastName
having count(c.CustomerID) > 1

--5. Display orders with the customer's first name and last name.

select Orders.*, Customers.FirstName,Customers.LastName
from Customers
inner join Orders
on Orders.CustomerID=Customers.CustomerID

--6. Retrieve employees hired in the year 2022.

select * from Employees



--7. Show customers who have placed orders on different dates.

select * from Customers
select * from Orders

select Customers.CustomerID,Customers.FirstName,Customers.LastName from Customers
inner join Orders
on Orders.CustomerID=Customers.CustomerID
where Orders.OrderDate in (select distinct Orders.OrderDate from Orders)


select distinct Orders.OrderDate from Orders

--8. Retrieve the employees with the second and third highest salaries.

select Salary from Employees
order by Salary desc
-- segundo y tercer salario más alto
select * from Employees
order by Salary desc
offset 1 rows
fetch next 2 rows only

--9. Find the total number of orders placed by each customer.

select * from Customers
select * from Orders

select Customers.CustomerID, Customers.FirstName,Customers.LastName, COUNT(Orders.CustomerID) as totalorders from Customers
left join Orders
on Customers.CustomerID=Orders.CustomerID
group by Customers.CustomerID, Customers.FirstName,Customers.LastName

--10. Retrieve employees who work in the IT department.

select * from Employees

select * from Employees
where Department='IT'

--11. Find customers who have not placed any orders.

select * from Customers
select * from Orders

select Customers.CustomerID,Customers.FirstName,Customers.LastName from Customers
inner join Orders
on Orders.CustomerID=Customers.CustomerID
where Orders.CustomerID is null

--12. Show the average salary of employees in each department.

select * from Customers
select * from Orders
select * from Employees

select Department, AVG(Salary) as avgSalarios
from Employees
group by Department

--13. Retrieve the employees with salaries above the average salary in their respective department.

select * from Employees

select AVG(Salary) from Employees

select CONCAT(FirstName,' ',LastName) as NOmbreCompleto,Salary
from Employees
where Salary > (select AVG(Salary) from Employees)

--14. Display the names of employees who were hired on the same day as 'John Smith'.

select * from Employees

select CONCAT(FirstName,' ',LastName) as NOmbreCompleto,HireDate
from Employees
where HireDate='2019-05-20'

--15. Find customers who have placed orders for consecutive days.

select DATEDIFF(DAY,'2019-05-20','2020-01-15') as diferencia

select * from Customers
select * from Orders

select distinct * from Customers c
inner join Orders o1
on c.CustomerID=o1.CustomerID

where DATEDIFF(DAY,'2019-05-20','2020-01-15') =1

--16. Find the nth highest salary from the Employees table.

select * from Employees
order by Salary desc


-- el quinto salario más alto

select * from Employees
order by Salary desc
offset 4 rows
fetch next 1 rows only

--con parámetro

declare @N int =5

select distinct salary
from Employees
order by Salary desc
offset @N -1 rows
fetch next 1 rows only

use Pruebas

--17. Show customers who have placed orders every day for the past week.

select * from Customers
select * from Orders

select distinct c.FirstName, c.LastName
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
where OrderDate between DATEADD(WEEK,-1,GETDATE()) and GETDATE()

--18. Retrieve orders that were shipped after their expected shipment date.

select * from Orders
where IsShipped =1

--19. Display the employees with their age (in years) calculated from the HireDate.

select * from Employees

select FirstName,LastName, datediff(year,HireDate,GETDATE()) as edad
from Employees

--20. Find the customers who have not placed any orders in the last 3 months.

select * from Customers
select * from Orders

select distinct c.FirstName, c.LastName
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
where OrderDate >= DATEADD(MONTH,-3,GETDATE())

--22. Show the customers who have the same first name or last name as employees.
select * from Employees
select * from Customers

select c.*
from Customers c where exists (
				select * from Employees e
				where c.FirstName=e.FirstName or c.LastName = e.LastName)


--23. Find the orders placed by the customers from the same city as 'John Smith'.

select * from Customers
select * from Orders

select o.* from Orders o
inner join Customers c
on o.CustomerID=c.CustomerID
where city= (select City
from Customers
where FirstName='Oliver' and LastName ='Smith')


select City
from Customers
where FirstName='Oliver' and LastName ='Smith'

--24. Retrieve customers who have placed orders for more than the average order amount.

select * from Customers
select * from Orders

select c.*,o.TotalAmount from Customers c
inner join Orders o
on o.CustomerID=c.CustomerID
where o.TotalAmount > (select avg(TotalAmount) from Orders)


select avg(TotalAmount) from Orders

---------------------------------------------------------------------
-------SQL Queries - Intermediate Level-------
---------------------------------------------------------------------

--25. Show the departments along with the number of employees in each department.
select * from Employees
select * from Orders
select * from Customers

select Department, count(*) as numeroEmpleados
from Employees
group by Department

--26. Retrieve the latest order for each customer.

select * from Orders
select * from Customers

select * from Orders o
inner join Customers c
on o.CustomerID=c.CustomerID
where OrderDate in (select max(OrderDate) from Orders)


select max(OrderDate) from Orders

--tambien así

SELECT
  CustomerID,
  OrderID,
  OrderDate
FROM
  Orders
ORDER BY
  CustomerID,
  OrderDate DESC

--27. Find the customers who have placed at least one order in each city.

select * from Orders
select * from Customers

select c.FirstName,c.LastName from Customers c
inner join Orders o
on o.CustomerID=c.CustomerID

select distinct City
from Customers
where exists (select * from orders where Customers.CustomerID=Orders.OrderID)


SELECT C.* FROM Customers C
WHERE NOT EXISTS (
    SELECT DISTINCT City FROM Customers
    WHERE NOT EXISTS (
        SELECT * FROM Orders
        WHERE Customers.CustomerID = Orders.CustomerID
        
    )
);

--28. Show the employees who have the same hire date as their manager.

SELECT E.* FROM Employees E
INNER JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE E.HireDate = M.HireDate;

--29. Retrieve the customers who have placed orders on all weekdays (Monday to Friday).

select * from Orders
select * from Customers

select * from Customers c
inner join Orders o
on c.CustomerID =o.CustomerID
where DATEPART(weekday,OrderDate) not between 6 and 7

select c.FirstName,c.LastName from Customers c
where not exists
(select * from Orders o
where c.CustomerID=o.CustomerID
and DATEPART(weekday,OrderDate)  between 6 and 7
)

select DATEPART(weekday,OrderDate)  from Orders

select DATENAME(weekday,orderDate) from Orders

--30. Find the total sales amount for each year.

select * from Orders

select YEAR(OrderDate) as año, sum(TotalAmount) as totalPoraÑo
from Orders
group by YEAR(OrderDate)











