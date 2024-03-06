--SQL Date and Time Interview Questions

--How do you find all records modified between two dates in SQL?

select * from sales.SalesOrderHeader

select * 
from Sales.SalesOrderHeader
where OrderDate between '2014-06-01T00:00:00.000'
and
'2014-06-30T00:00:00.000'


select * 
from Sales.SalesOrderHeader
where OrderDate >= '2014-06-01T00:00:00.000'
and OrderDate <
'2014-06-30T00:00:00.000'

-------------------------------------------
-------------------------------------------
--How do you extract the year from a date in SQL?

select * from sales.SalesOrderHeader

select YEAR(OrderDate) --saco solo al a�o
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--How can you add 3 months to a given date in SQL?
select * from sales.SalesOrderHeader

select DATEADD(MONTH,3,OrderDate)
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--How do you find the number of days between two dates in SQL?
select * from sales.SalesOrderHeader

select DATEDIFF(DAY,'2014-06-01T00:00:00.000','2014-06-30T00:00:00.000') as diffdaypositivo

select DATEDIFF(DAY,'2014-06-30T00:00:00.000','2014-06-01T00:00:00.000') as diffdaynegativo

-------------------------------------------
-------------------------------------------

--Explique la diferencia entre los tipos de datos DATE y DATETIME.
--DATE almacena �nicamente la fecha sin ninguna informaci�n horaria,
--mientras que DATETIME almacena tanto la fecha como la hora.


-------------------------------------------
-------------------------------------------
--How do you convert a date to a different date format in SQL?

select * from sales.SalesOrderHeader

select CONVERT(varchar,OrderDate,105) as conversi�n
from sales.SalesOrderHeader

select CONVERT(varchar,OrderDate,112) as conversi�n
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--�C�mo encontrar los registros que corresponden
--a un mes y un a�o determinados?
--Puede utilizar las funciones MONTH() y YEAR() 
--en combinaci�n con la cl�usula WHERE. Por ejemplo

select * from sales.SalesOrderHeader

select * 
from sales.SalesOrderHeader
where MONTH(OrderDate)=6 and year(OrderDate)=2014

-------------------------------------------
-------------------------------------------
--�C�mo se gestionan las conversiones de zona horaria en SQL?
--Para manejar las conversiones de zona horaria, 
--puede utilizar la cl�usula AT TIME ZONE (para SQL Server)
--o la funci�n AT TIME ZONE (para PostgreSQL).

select OrderDate at time zone 'UTC' as converted_date 
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--�Se puede aplicar una restricci�n para garantizar que una 
--columna de fecha contenga siempre fechas futuras?
--S�, puede utilizar una restricci�n con la palabra clave CHECK.

select * from sales.SalesOrderHeader

ALTER TABLE table_name
ADD CONSTRAINT future_date_constraint CHECK (date_column > GETDATE());

--�C�mo puede averiguar el primer y el �ltimo d�a del mes en curso?
--Puede utilizar la funci�n EOMONTH() para hallar el �ltimo d�a y 
--luego restar el n�mero de d�as del mes menos uno para hallar el primer d�a.

select DATEADD(DAY,1,EOMONTH(getdate(),-1)) as primerDiaMes,
EOMONTH(GETDATE()) as ultimoDiaMes


-------------------------------------------
-------------------------------------------

--�C�mo encontrar registros con intervalos de fechas SOLAPADOS en SQL?
--Puede utilizar el operador BETWEEN para buscar intervalos
--de fechas superpuestos.

select * from sales.SalesOrderHeader

select *
from sales.SalesOrderHeader
where OrderDate between '2013-01-01'
and '2013-12-31'


-------------------------------------------
-------------------------------------------
select * from sales.SalesOrderHeader

--�C�mo se puede calcular la edad de una persona a 
--partir de su fecha de nacimiento?
--Puede utilizar la funci�n DATEDIFF() para calcular la diferencia en a�os 
--entre la fecha de nacimiento y la fecha actual.

select DATEDIFF(YEAR,OrderDate,GETDATE()) as age
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

select * from sales.SalesOrderHeader

--�C�mo se obtiene la fecha y hora actuales en SQL?
--Puede utilizar la funci�n GETDATE() o CURRENT_TIMESTAMP
--para obtener la fecha y hora actuales. Por ejemplo:

select GETDATE() as current_date_time
select CURRENT_TIMESTAMP as current_date_time2

-------------------------------------------
-------------------------------------------
--OJOOOOOOOOOOOOOOOO!!!!
--�C�mo se puede convertir una cadena en una fecha en SQL?
--Puede utilizar las funciones CAST() o CONVERT()
--para convertir una cadena en una fecha.

select * from sales.SalesOrderHeader

select CONVERT(date,'20240214') as convertDate
select CONVERT(datetime,'20240214') as convertDatetime

-------------------------------------------
-------------------------------------------
select * from sales.SalesOrderHeader

--�C�mo encontrar el d�a de la semana para una fecha dada en SQL?
--Puede utilizar la funci�n DATEPART() 
--con el par�metro dw para encontrar el d�a de la semana 
--(domingo = 1, lunes = 2, etc.). Por ejemplo:

select OrderDate,DATEPART(DW,OrderDate) as 'D�a de la semana'
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--�C�mo se calcula el n�mero de d�as laborables 
--(excluidos los fines de semana) entre dos fechas?
--Puede utilizar una combinaci�n de las funciones DATEDIFF() y DATEPART() 
--para hallar el n�mero de d�as laborables entre dos fechas. Por ejemplo:

select MIN(OrderDate)
from sales.SalesOrderHeader

select max(OrderDate)
from sales.SalesOrderHeader

DECLARE @FechaDesde DATETIME = '20140601';
DECLARE @FechaHasta DATETIME = '20140630';
DECLARE @DiasSemana INT = 0;
DECLARE @Sabado INT = 0;
DECLARE @Domingo INT = 0;

WHILE (@FechaDesde < @FechaHasta)
BEGIN
    IF (DATEPART(WEEKDAY, @FechaDesde) = 7) -- Domingo
        SET @Domingo = @Domingo + 1;
    ELSE IF (DATEPART(WEEKDAY, @FechaDesde) = 6) -- S�bado
        SET @Sabado = @Sabado + 1;
    ELSE
        SET @DiasSemana = @DiasSemana + 1; -- D�as laborables
    SET @FechaDesde = DATEADD(DAY, 1, @FechaDesde);
END

SELECT @DiasSemana AS 'DiasLaborables', @Sabado AS 'Sabados', @Domingo AS 'Domingos';


-------------------------------------------
-------------------------------------------

--�C�mo se extrae la parte de la hora de una columna DATETIME en SQL?
--Puede utilizar la funci�n CONVERT() con un par�metro 
--de estilo de 108 para extraer 
--la parte de la hora. Por ejemplo:

select CONVERT(time,OrderDate,108) as horaExtraida
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--�C�mo puede encontrar los registros con la fecha m�s reciente en una tabla?
--Puede utilizar la funci�n MAX() para encontrar 
--la fecha m�s tard�a de una tabla. 
--Por ejemplo:


select max(OrderDate) as 'Fecha m�s actual'
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--A�OS BISIESTOS

--Explique el concepto de a�os bisiestos
--y c�mo identificar�a si un a�o es bisiesto en SQL.
--Los a�os bisiestos son a�os con un d�a m�s, 
--el 29 de febrero, para mantener el a�o natural sincronizado 
--con el a�o astron�mico. En SQL, 
--se puede identificar un a�o bisiesto comprobando 
--si el a�o es divisible por 4, excepto los a�os divisibles por 100, 
--que no son bisiestos a menos que tambi�n sean divisibles por 400. 
--Por ejemplo:

SELECT distinct year(OrderDate) as 'A�o',
CASE
WHEN (year(OrderDate) % 4 = 0
AND year(OrderDate) % 100 != 0) OR (year(OrderDate) % 400 = 0)
THEN 'a�o bisiesto'
ELSE 'No a�o bisiesto'
END
AS anio_bisiesto_status FROM sales.SalesOrderHeader;







