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

select YEAR(OrderDate) --saco solo al año
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
--DATE almacena únicamente la fecha sin ninguna información horaria,
--mientras que DATETIME almacena tanto la fecha como la hora.


-------------------------------------------
-------------------------------------------
--How do you convert a date to a different date format in SQL?

select * from sales.SalesOrderHeader

select CONVERT(varchar,OrderDate,105) as conversión
from sales.SalesOrderHeader

select CONVERT(varchar,OrderDate,112) as conversión
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--¿Cómo encontrar los registros que corresponden
--a un mes y un año determinados?
--Puede utilizar las funciones MONTH() y YEAR() 
--en combinación con la cláusula WHERE. Por ejemplo

select * from sales.SalesOrderHeader

select * 
from sales.SalesOrderHeader
where MONTH(OrderDate)=6 and year(OrderDate)=2014

-------------------------------------------
-------------------------------------------
--¿Cómo se gestionan las conversiones de zona horaria en SQL?
--Para manejar las conversiones de zona horaria, 
--puede utilizar la cláusula AT TIME ZONE (para SQL Server)
--o la función AT TIME ZONE (para PostgreSQL).

select OrderDate at time zone 'UTC' as converted_date 
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------
--¿Se puede aplicar una restricción para garantizar que una 
--columna de fecha contenga siempre fechas futuras?
--Sí, puede utilizar una restricción con la palabra clave CHECK.

select * from sales.SalesOrderHeader

ALTER TABLE table_name
ADD CONSTRAINT future_date_constraint CHECK (date_column > GETDATE());

--¿Cómo puede averiguar el primer y el último día del mes en curso?
--Puede utilizar la función EOMONTH() para hallar el último día y 
--luego restar el número de días del mes menos uno para hallar el primer día.

select DATEADD(DAY,1,EOMONTH(getdate(),-1)) as primerDiaMes,
EOMONTH(GETDATE()) as ultimoDiaMes


-------------------------------------------
-------------------------------------------

--¿Cómo encontrar registros con intervalos de fechas SOLAPADOS en SQL?
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

--¿Cómo se puede calcular la edad de una persona a 
--partir de su fecha de nacimiento?
--Puede utilizar la función DATEDIFF() para calcular la diferencia en años 
--entre la fecha de nacimiento y la fecha actual.

select DATEDIFF(YEAR,OrderDate,GETDATE()) as age
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

select * from sales.SalesOrderHeader

--¿Cómo se obtiene la fecha y hora actuales en SQL?
--Puede utilizar la función GETDATE() o CURRENT_TIMESTAMP
--para obtener la fecha y hora actuales. Por ejemplo:

select GETDATE() as current_date_time
select CURRENT_TIMESTAMP as current_date_time2

-------------------------------------------
-------------------------------------------
--OJOOOOOOOOOOOOOOOO!!!!
--¿Cómo se puede convertir una cadena en una fecha en SQL?
--Puede utilizar las funciones CAST() o CONVERT()
--para convertir una cadena en una fecha.

select * from sales.SalesOrderHeader

select CONVERT(date,'20240214') as convertDate
select CONVERT(datetime,'20240214') as convertDatetime

-------------------------------------------
-------------------------------------------
select * from sales.SalesOrderHeader

--¿Cómo encontrar el día de la semana para una fecha dada en SQL?
--Puede utilizar la función DATEPART() 
--con el parámetro dw para encontrar el día de la semana 
--(domingo = 1, lunes = 2, etc.). Por ejemplo:

select OrderDate,DATEPART(DW,OrderDate) as 'Día de la semana'
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--¿Cómo se calcula el número de días laborables 
--(excluidos los fines de semana) entre dos fechas?
--Puede utilizar una combinación de las funciones DATEDIFF() y DATEPART() 
--para hallar el número de días laborables entre dos fechas. Por ejemplo:

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
    ELSE IF (DATEPART(WEEKDAY, @FechaDesde) = 6) -- Sábado
        SET @Sabado = @Sabado + 1;
    ELSE
        SET @DiasSemana = @DiasSemana + 1; -- Días laborables
    SET @FechaDesde = DATEADD(DAY, 1, @FechaDesde);
END

SELECT @DiasSemana AS 'DiasLaborables', @Sabado AS 'Sabados', @Domingo AS 'Domingos';


-------------------------------------------
-------------------------------------------

--¿Cómo se extrae la parte de la hora de una columna DATETIME en SQL?
--Puede utilizar la función CONVERT() con un parámetro 
--de estilo de 108 para extraer 
--la parte de la hora. Por ejemplo:

select CONVERT(time,OrderDate,108) as horaExtraida
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--¿Cómo puede encontrar los registros con la fecha más reciente en una tabla?
--Puede utilizar la función MAX() para encontrar 
--la fecha más tardía de una tabla. 
--Por ejemplo:


select max(OrderDate) as 'Fecha más actual'
from sales.SalesOrderHeader

-------------------------------------------
-------------------------------------------

--AÑOS BISIESTOS

--Explique el concepto de años bisiestos
--y cómo identificaría si un año es bisiesto en SQL.
--Los años bisiestos son años con un día más, 
--el 29 de febrero, para mantener el año natural sincronizado 
--con el año astronómico. En SQL, 
--se puede identificar un año bisiesto comprobando 
--si el año es divisible por 4, excepto los años divisibles por 100, 
--que no son bisiestos a menos que también sean divisibles por 400. 
--Por ejemplo:

SELECT distinct year(OrderDate) as 'Año',
CASE
WHEN (year(OrderDate) % 4 = 0
AND year(OrderDate) % 100 != 0) OR (year(OrderDate) % 400 = 0)
THEN 'año bisiesto'
ELSE 'No año bisiesto'
END
AS anio_bisiesto_status FROM sales.SalesOrderHeader;







