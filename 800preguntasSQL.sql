use Pruebas

CREATE TABLE DetalleDelEmpleado (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2),
    JoiningDate DATETIME,
    Department NVARCHAR(50),
    Gender NVARCHAR(10)
);
--Esta tabla tiene los siguientes campos:

--    EmployeeID: Identificador único del empleado.
--    FirstName: Nombre del empleado.
--    LastName: Apellido del empleado.
--    Salary: Salario del empleado (con dos decimales).
--    JoiningDate: Fecha y hora de ingreso del empleado.
--    Department: Departamento al que pertenece el empleado.
--    Gender: Género del empleado (por ejemplo, “Femenino” o “Masculino”).




 -- Insertar registros en la tabla Detalle del Empleado
INSERT INTO [DetalledelEmpleado] (EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender)
VALUES
    (1001, 'Ana', 'García', 45000, '2022-01-15T10:30:00', 'Ventas', 'Femenino'),
    (1002, 'Carlos', 'Rodríguez', 52000, '2021-11-03T14:45:00', 'Finanzas', 'Masculino'),
    (1003, 'Laura', 'Pérez', 38000, '2023-02-20T09:15:00', 'Recursos Humanos', 'Femenino'),
    (1004, 'Javier', 'López', 60000, '2020-07-10T16:20:00', 'Tecnología', 'Masculino'),
    (1005, 'María', 'Martínez', 42000, '2022-05-05T11:00:00', 'Marketing', 'Femenino');

select * from DetalleDelEmpleado

select UPPER(FirstName)
from DetalleDelEmpleado

select lower(FirstName)
from DetalleDelEmpleado

select FirstName + ' ' + LastName as Name
from DetalleDelEmpleado

select *
from DetalleDelEmpleado
where FirstName = 'Ana'



select *
from DetalleDelEmpleado
where FirstName like 'a%' --esto es que empiece con la a


select *
from DetalleDelEmpleado
where FirstName like '%r%'


select * from DetalleDelEmpleado


select *
from DetalleDelEmpleado
where FirstName like '%a'


select *
from DetalleDelEmpleado
where FirstName like '[a-j]%'

select * from DetalleDelEmpleado


select *
from DetalleDelEmpleado
where FirstName like '[^a-j]%'

select *
from DetalleDelEmpleado
where Gender like '______no'

select *
from DetalleDelEmpleado
where FirstName like 'L____'

select *
from DetalleDelEmpleado
where FirstName like '%ar%'

select MAX(Salary)
from DetalleDelEmpleado
select min(Salary)
from DetalleDelEmpleado

select CONVERT(varchar(12),JoiningDate,106) as fecha
from DetalleDelEmpleado

select * from DetalleDelEmpleado

select CONVERT(varchar(12),JoiningDate,111) as fecha
from DetalleDelEmpleado

select CONVERT(varchar(8),JoiningDate,108) as hora
from DetalleDelEmpleado

select DATEPART(YEAR,JoiningDate) as año
from DetalleDelEmpleado


select DATEPART(MONTH,JoiningDate) as año
from DetalleDelEmpleado


select GETDATE()
select GETUTCDATE() --1 hora menos

select FirstName,GETDATE() as 'Current date', JoiningDate,
DATEDIFF(MONTH,JoiningDate,GETDATE()) as 'Total Months'
from DetalleDelEmpleado



select FirstName,GETDATE() as 'Current date', JoiningDate,
DATEDIFF(DAY,JoiningDate,GETDATE()) as 'Total Months'
from DetalleDelEmpleado

select *
from DetalleDelEmpleado
where DATEPART(YEAR,JoiningDate) = '2023'

select * from DetalleDelEmpleado

select *
from DetalleDelEmpleado
where DATEPART(MONTH,JoiningDate) = '1'

select *
from DetalleDelEmpleado
where JoiningDate between '20230101' and '20231231'


select COUNT(*) as 'Total Empleados'
from DetalleDelEmpleado 

select * from DetalleDelEmpleado


select top 1 *
from DetalleDelEmpleado

select * 
from DetalleDelEmpleado
where FirstName in ('ana','laura','javier')


select * 
from DetalleDelEmpleado
where FirstName not in ('ana','laura','javier')


select LTRIM(FirstName) as 'First Name'
from DetalleDelEmpleado


select FirstName, 
case 
	when Gender = 'Masculino' then 'M'
	when Gender = 'Femenino' then 'F'
	end as 'Gender'
from DetalleDelEmpleado



select 'Hello' + ' ' + FirstName
from DetalleDelEmpleado


select * 
from DetalleDelEmpleado
where Salary > '45000'


select * 
from DetalleDelEmpleado
where Salary < '45000'


select * 
from DetalleDelEmpleado
where Salary between '42000' and '52000'
----------------------------------------------------------------------------------------------------------
--segundo salario
select Salary 
from DetalleDelEmpleado
order by Salary desc

select top 1 salary from
(select top 2 salary
from DetalleDelEmpleado
order by Salary desc) T
order by Salary asc


--Primero, se seleccionan las dos filas con los salarios más altos de la
--tabla DetalleDelEmpleado utilizando la subconsulta interna: 
--SELECT TOP 2 salary
--FROM DetalleDelEmpleado
--ORDER BY Salary DESC

--Aquí, estamos ordenando los salarios en orden descendente (DESC) para obtener los dos salarios más altos.

--Luego, la subconsulta interna se trata como una tabla temporal llamada T.

--Finalmente, se selecciona el salario más bajo de las dos filas obtenidas en la subconsulta interna:

--SELECT TOP 1 salary
--FROM T
--ORDER BY Salary ASC

--Aquí, estamos ordenando los salarios en orden ascendente (ASC)
--para obtener el salario más bajo de los dos.

--En resumen, esta consulta devuelve el salario más bajo
--entre los dos salarios más altos de la tabla DetalleDelEmpleado.
--Es una forma interesante de obtener información sobre los salarios extremos en la tabla. 
--------------------------------------------------------------------------------------------------------------



CREATE TABLE detalle_de_proyecto (
    ProjectDetailID INT PRIMARY KEY,
    EmployeeDetailID INT,
    ProjectName NVARCHAR(255)
);


-- Insert 1
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (1, 1, 'Proyecto A');

-- Insert 2
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (2, 3, 'Proyecto B');

-- Insert 3
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (3, 3, 'Proyecto C');

-- Insert 4
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (4, 1, 'Proyecto D');

-- Insert 5
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (5, 3, 'Proyecto E');

-- Insert 6
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (6, 2, 'Proyecto F');

-- Insert 7
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (7, 4, 'Proyecto G');

-- Insert 8
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (8, 1, 'Proyecto H');

-- Insert 9
INSERT INTO detalle_de_proyecto (ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES (9, 6, 'Proyecto I');

select * from detalle_de_proyecto



select Department, SUM(salary) as 'Total Salario'
from DetalleDelEmpleado
group by Department



select Department, SUM(salary) as 'Total Salario'
from DetalleDelEmpleado
group by Department
order by SUM(Salary) asc


select Department, SUM(salary) as 'Total Salario'
from DetalleDelEmpleado
group by Department
order by SUM(Salary) desc

select *
from DetalleDelEmpleado


select Department,COUNT(*) as 'Dept Counts', SUM(salary) as 'Total Salario'
from DetalleDelEmpleado
group by Department


select Department, round(avg(salary),2,1) as 'media Salario'
from DetalleDelEmpleado
group by Department
order by round(avg(salary),2,1) desc


select Department, MAX(Salary) as 'max Salario'
from DetalleDelEmpleado
group by Department
order by MAX(Salary)  asc


select Department, min(Salary) as 'max Salario'
from DetalleDelEmpleado
group by Department
order by min(Salary)  asc

select * from detalle_de_proyecto


select ProjectName, COUNT(*) as 'NoofEmpl'
from detalle_de_proyecto
group by ProjectName
having COUNT(*) > 0

------------------------------------------------------------------------
------------------------------------------------------------------------
--SET 6 
------------------------------------------------------------------------
------------------------------------------------------------------------
select * from DetalleDelEmpleado
select * from detalle_de_proyecto

update DetalleDelEmpleado set EmployeeID = 5
where EmployeeID = 1005

select e.FirstName,p.ProjectName
from DetalleDelEmpleado e
inner join detalle_de_proyecto p
on p.ProjectDetailID=e.EmployeeID


select e.FirstName,p.ProjectName
from DetalleDelEmpleado e
left outer join detalle_de_proyecto p
on p.ProjectDetailID=e.EmployeeID
order by e.FirstName

select ISNULL(e.FirstName,'No asignado') as 'nombre',ISNULL(p.ProjectName,'proyecto no asignado') as 'proyecto'
from DetalleDelEmpleado e
full outer join detalle_de_proyecto p
on p.ProjectDetailID=e.EmployeeID
order by e.FirstName

select ISNULL(e.FirstName,'No asignado') as 'nombre',ISNULL(p.ProjectName,'proyecto no asignado') as 'proyecto'
from DetalleDelEmpleado e
right outer join detalle_de_proyecto p
on p.ProjectDetailID=e.EmployeeID
order by e.FirstName


select e.FirstName as 'nombre',ISNULL(p.ProjectName,'proyecto no asignado') as 'proyecto'
from DetalleDelEmpleado e
right outer join detalle_de_proyecto p
on p.ProjectDetailID=e.EmployeeID
where e.FirstName is null
order by e.FirstName


select p.ProjectName from DetalleDelEmpleado e
right outer join detalle_de_proyecto p
on p.EmployeeDetailID = e.EmployeeID


select * from DetalleDelEmpleado
select * from detalle_de_proyecto

--los que trabajan en más de un proyecto
select e.EmployeeID, e.FirstName, p.ProjectName
from DetalleDelEmpleado e
inner join detalle_de_proyecto p
on e.EmployeeID=p.EmployeeDetailID
where e.EmployeeID in
(select EmployeeDetailID
from detalle_de_proyecto
group by EmployeeDetailID
having COUNT(*)>1)


------------------------------------------------------------------------
------------------------------------------------------------------------
--SET 7
------------------------------------------------------------------------
------------------------------------------------------------------------
