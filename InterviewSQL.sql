use AdventureWorks2019

select FirstName, LastName,CONCAT(FirstName,' ',LastName) as nombreCompleto ,GETDATE() as fecha
from Person.Person

select * from HumanResources.Employee
where JobTitle='Senior Tool Designer'
-----------
--COMBINAR DOS TABLAS
select * from Person.Person
select * from Person.PersonPhone

select FirstName, LastName, PhoneNumber
from person.Person as p
left join Person.PersonPhone as t
on p.BusinessEntityID= t.BusinessEntityID
---------------------
--SEGUNDO SALARIO MÁS ALTO
CREATE TABLE Salarios (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Salario FLOAT
);

INSERT INTO Salarios (Nombre, Apellido, Salario)
VALUES ('Juan', 'Pérez', RAND() * 100000),
       ('María', 'García', RAND() * 100000),
       ('Pedro', 'Martínez', RAND() * 100000),
       ('Lucía', 'Sánchez', RAND() * 100000);

select * from Salarios
order by Salario desc

select Salario from Salarios
where salario in (select Salario
from Salarios
order by Salario desc
offset 1 rows
fetch next 1 rows only)
order by Salario desc





