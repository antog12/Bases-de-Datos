--use Pruebas

-- drop Employee table if already exists
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL
BEGIN
PRINT 'Employee Table Exists, dropping it now'
DROP TABLE Employee;
END


-- drop Department table if already exists
IF OBJECT_ID('dbo.Department', 'U') IS NOT NULL
BEGIN
PRINT 'Department Table Exists, dropping it now'
DROP TABLE Department;
END

-------------------------------------
-------------------------------------

-- create table ddl statments
CREATE TABLE Employee(
emp_id INTEGER PRIMARY KEY, 
dept_id INTEGER,
mngr_id INTEGER, emp_name VARCHAR(20), 
salary INTEGER);
CREATE TABLE Department(
dept_id INTEGER PRIMARY KEY, 
dept_name VARCHAR(20));
-- alter table to add foreign keys
ALTER TABLE Employee ADD FOREIGN KEY (mngr_id)
REFERENCES Employee(emp_id);
ALTER TABLE Employee ADD FOREIGN KEY (dept_id)
REFERENCES Department(dept_id);
-- populating department table with sample data
INSERT INTO Department (dept_id, dept_name)
VALUES
(1, 'Finance'),
(2, 'Legal'),
(3, 'IT'),
(4, 'Admin'),
(5, 'Empty Department');
-- populating employee table with sample data
INSERT INTO Employee(emp_id, dept_id, mngr_id, emp_name, salary)
VALUES( 1, 1, 1, 'CEO', 100),
( 2, 3, 1, 'CTO', 95),
( 3, 2, 1, 'CFO', 100),
( 4, 3, 2, 'Java Developer', 90),
( 5, 3, 2, 'DBA', 90),
( 6, 4, 1, 'Adm 1', 20),
( 7, 4, 1, 'Adm 2', 110),
( 8, 3, 2, 'Web Developer', 50),
( 9, 3, 1, 'Middleware', 60),
( 10, 2, 3, 'Legal 1', 110),
( 11, 3, 3, 'Network', 80),
( 12, 3, 1, 'UNIX', 200);

select * from Employee
select * from Department

-----------------------------------------------------
-----------------------------------------------------
--Can you write an SQL query to show Employee (names) 
--who have a bigger salary than their manager?

select a.emp_name
from Employee a 
inner join Employee b
on b.mngr_id = a.emp_id
where a.salary = b.salary

-----------------------------------------------------
-----------------------------------------------------

--Write an SQL query to find Employees who have the biggest salary
--in their Department?
select e.emp_name,e.dept_id
from Employee e
inner join
(select e.dept_id, MAX(salary) as MaxSalary
from Employee e
inner join Department d
on d.dept_id=e.dept_id
group by e.dept_id) d
on e.salary=d.MaxSalary
and 
e.dept_id=d.dept_id

-----------------------------------------------------
-----------------------------------------------------

--Write an SQL query to list Departments that have less 
--than 3 people in it?

select dept_id, COUNT(emp_name) as 'number of employees'
from Employee
group by dept_id
having COUNT(emp_name) < 3

-----------------------------------------------------
-----------------------------------------------------

--Write an SQL query to show all Departments along 
--with the number of people there?

select * from Employee
select * from Department

select d.dept_name, COUNT(e.dept_id) as 'number of employees'
from Employee e full outer join Department d
on d.dept_id=e.dept_id
group by d.dept_name

-----------------------------------------------------
-----------------------------------------------------

--Can you write an SQL query to show all Employees
--that don't have a manager in the same department?

select * from Employee
select * from Department



select a.emp_name
from Employee a 
join Employee b
on b.mngr_id = a.emp_id
where a.dept_id != b.dept_id


-----------------------------------------------------
-----------------------------------------------------

--Can you write SQL query to list all Departments 
--along with the total salary there?

select * from Employee
select * from Department

select d.dept_name, SUM(salary) as 'Total Salario'
from Employee e full outer join Department d
on d.dept_id=e.dept_id
group by d.dept_name

-----------------------------------------------------
-----------------------------------------------------

--How do you find the second 
--highest salary in the employee table?

select * from Employee
select * from Department

select salary from Employee
where salary in (select salary
from Employee
order by salary desc
offset 1 rows
fetch next 1 rows only)
order by salary desc

select salary
from Employee
order by salary desc

--en este caso como tiene duplicados, vamos a hacerlo con
--RANK para elegir el registro que queramos

WITH SalariosOrdenados AS (
    SELECT salary,
           RANK() OVER (ORDER BY salary DESC) AS Ranking
    FROM Employee
)
SELECT salary
FROM SalariosOrdenados
WHERE Ranking = 2;


-----------------------------------------------------
-----------------------------------------------------

--¿Cómo encontrar las filas duplicadas en una tabla?

select * from Employee
select * from Department

select emp_name, COUNT(*) as 'total'
from Employee
group by emp_name
having COUNT(*) >1

-----------------------------------------------------
-----------------------------------------------------
--¿Cómo se copian todas las filas 
--de una tabla mediante una consulta SQL SERVER?

--Para copiar todas las filas de una tabla a otra en SQL Server,
--puedes utilizar la sentencia INSERT INTO.
--A continuación, te muestro dos enfoques posibles:

--    Usando la sentencia INSERT INTO: 
--	Supongamos que tienes dos tablas: 
--	Tabla1 en la base de datos Base1 y 
--	Tabla2 en la base de datos Base2. 
--	Ambas tablas tienen estructuras idénticas. 
--	Para copiar todas las filas de Tabla1 a Tabla2, 
--	puedes ejecutar la siguiente consulta:

--    INSERT INTO Base2.Tabla2 (columna1, columna2, columna3, ...)
--    SELECT columna1, columna2, columna3, ...
--    FROM Base1.Tabla1;

--Usando SELECT INTO: 
--Si deseas crear una nueva tabla con los datos de otra tabla, 
--puedes utilizar SELECT INTO. 
--Por ejemplo:

--SELECT *
--INTO Base2.Tabla2
--FROM Base1.Tabla1;


-----------------------------------------------------
-----------------------------------------------------
--How do you remove the duplicate rows from the table?

select * from Employee
select * from Department
--busacar duplicados
select emp_name, ROW_NUMBER() over (order by emp_name desc) row_number
from Employee
--eliminar duplicados
delete from Employee where row_number> 1.

--Usando ROW_NUMBER:

--    La función ROW_NUMBER, introducida en SQL Server 2005, simplifica la eliminación de duplicados.
--    El siguiente script utiliza ROW_NUMBER para particionar los datos según la columna key_value y elimina registros con un valor DupRank mayor que 1 (indicando duplicados):

--DELETE T FROM (
--    SELECT *, DupRank = ROW_NUMBER() OVER (PARTITION BY key_value ORDER BY (SELECT NULL))
--    FROM original_table
--) AS T
--WHERE DupRank > 1;

-----------------------------------------------------
-----------------------------------------------------
--How to find 2nd highest salary without using a co-related subquery?

select * from Employee

SELECT TOP 1 emp_name, monto
FROM (
    SELECT TOP 2 emp_name, SUM(salary) AS MONTO
    FROM Employee
    GROUP BY emp_name
    ORDER BY SUM(salary) DESC
) AS T
ORDER BY T.Monto ASC;

select emp_name, salary
from Employee
order by salary desc

-----------------------------------------------------
-----------------------------------------------------

--There exists an Order table and a Customer table, 
--find all Customers who have never ordered (solution)

--una solucion:

SELECT *
FROM clientes
WHERE Codigo_de_cliente NOT IN (SELECT DISTINCT Codigo_de_cliente FROM pedidos);


--otra solución:

SELECT DISTINCT clientes.*
FROM clientes
LEFT JOIN pedidos ON clientes.Codigo_de_cliente = pedidos.Codigo_de_cliente
WHERE pedidos.Numero_de_Pedido IS NULL;












