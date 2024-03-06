--CONOCIMIENTOS PARA ENTREVIASTAS

--SQL Date Format Options with SQL CONVERT Function


select CONVERT(varchar,GETDATE(),3) as 'Fecha actual'
select CONVERT(varchar,GETDATE(),111) as 'Fecha actual'
select CONVERT(varchar,GETDATE(),112) as 'Fecha actual'
select CONVERT(varchar,GETDATE(),101) as 'Fecha actual'
select replace(convert(varchar, getdate(),101),'/','') as 'Fecha actual'


select CONVERT(varchar,GETDATE(),8) as 'hora actual'

--SQL Date Format dd/mm/yyyy with SQL CONVERT

declare @fecha datetime
set @fecha = GETDATE()

--dd/mm/yyyy with 4 DIGIT YEAR
select CONVERT(varchar(10),@fecha,103) as CurrentDateFormattedAsText

--dd/mm/yy with 2 DIGIT YEAR
select CONVERT(varchar(10),@fecha,3) as CurrentDateFormattedAsText


-- pull data from a database table
-- The date used for this example was January 25, 2013. 
--SELECT a datetime column as a string formatted dd/mm/yyyy (4 digit year)

select  top 3 CONVERT(char(10),ShipDate,103) as ExpectedDeliveryDateFormattedAsText
from Purchasing.PurchaseOrderHeader
where OrderDate < @fecha

--SELECT a datetime column as a string formatted dd/mm/yy (2 digit year)
select  top 3 CONVERT(char(8),ShipDate,3) as ExpectedDeliveryDateFormattedAsText
from Purchasing.PurchaseOrderHeader
where OrderDate < @fecha


--SQL Date Format mm/dd/yyyy with SQL CONVERT


declare @fecha datetime
set @fecha = GETDATE()

--mm/dd/yyyy with 4 DIGIT YEAR

select CONVERT(varchar(10),@fecha,101) as CurrentDateFormattedAsText

--mm/dd/yy with 2 DIGIT YEAR
select CONVERT(varchar(8),@fecha,1) as CurrentDateFormattedAsText

--SQL Date Format yyyy mm dd with SQL CONVERT

declare @fecha datetime
set @fecha = GETDATE()

--mm/dd/yyyy with 4 DIGIT YEAR

select REPLACE(CONVERT(varchar(10),@fecha,102),'.',' ') as CurrentDateFormattedAsText
--mm/dd/yy with 2 DIGIT YEAR
select REPLACE(CONVERT(varchar(8),@fecha,2),'.',' ') as CurrentDateFormattedAsText

--SQL Date Format yyyymmdd with SQL CONVERT

declare @fecha datetime
set @fecha = GETDATE()

--mm/dd/yyyy with 4 DIGIT YEAR

select REPLACE(CONVERT(varchar(10),@fecha,112),'.',' ') as CurrentDateFormattedAsText
--mm/dd/yy with 2 DIGIT YEAR
select REPLACE(CONVERT(varchar(8),@fecha,12),'.',' ') as CurrentDateFormattedAsText


--SQL Date format ddmmyyyy with SQL CONVERT

declare @fecha datetime
set @fecha = GETDATE()

--ddmmyyyy with 4 DIGIT YEAR
select REPLACE(CONVERT(varchar(10),@fecha,104),'.','') as CurrentDateFormattedAsText
--ddmmyy  with 2 DIGIT YEAR
select REPLACE(CONVERT(varchar(8),@fecha,4),'.','') as CurrentDateFormattedAsText

--SQL Date Format yyyy-mm-dd with SQL CONVERT

declare @fecha datetime
set @fecha = GETDATE()

--yyyy-mm-dd with 4 DIGIT YEAR
select REPLACE(CONVERT(varchar(10),@fecha,111),'/','-') as CurrentDateFormattedAsText
--yy-mm-dd  with 2 DIGIT YEAR
select REPLACE(CONVERT(varchar(8),@fecha,11),'/','-') as CurrentDateFormattedAsText

--SQL Date Format mm/dd/yyyy with SQL CONVERT

DECLARE @Datetime DATETIME;
SET @Datetime = GETDATE();
 
--mm/dd/yyyy with 4 DIGIT YEAR
SELECT REPLACE(CONVERT(VARCHAR(10), @Datetime, 110), '/', '-') CurrentDateFormattedAsText;
 
--mm/dd/yy  with 2 DIGIT YEAR
SELECT REPLACE(CONVERT(VARCHAR(8), @Datetime,   10), '/', '-') CurrentDateFormattedAsText;

---------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--SQL Date Format examples using SQL FORMAT Function

select FORMAT(GETDATE(),'dd-MM-yy') as date
select FORMAT(GETDATE(),'hh:mm:ss') as time

--SQL date format dd/MM/yyyy with SQL FORMAT

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'dd/MM/yyyy') as formattedDate
from 
       Sales.Currency


--Format date SQL MM/dd/yyyy with SQL FORMAT 

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'MM/dd/yyyy') as formattedDate
from 
       Sales.Currency


--SQL date format yyyy MM dd with SQL FORMAT (SEPARADO)

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'yyyy MM dd') as formattedDate
from 
       Sales.Currency

--SQL date format yyyyMMdd with SQL FORMAT

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'yyyyMMdd') as formattedDate
from 
       Sales.Currency

--SQL format date ddMMyyyy with SQL FORMAT

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'ddMMyyyy') as formattedDate
from 
       Sales.Currency

--SQL format date yyyy-MM-dd with SQL FORMAT 

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'yyyy-MM-dd') as formattedDate
from 
       Sales.Currency

--SQL date format MM/dd/yyyy with SQL FORMAT

select 
       CurrencyCode,
	   Name,
	   FORMAT(ModifiedDate, 'MM/dd/yyyy') as formattedDate
from 
       Sales.Currency


---------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--TABLA CALENDARIO--

select DATEADD(YEAR,30,GETDATE())
select DATEADD(DAY,-1,DATEADD(YEAR,30,GETDATE()))
----------------------
--En primer lugar, tenemos un CTE recursivo que devuelve una secuencia que representa el número
--de días entre nuestra fecha de inicio (2010-01-01) y 30 años después menos un día (2039-12-31):

declare @startdate date = getdate()
declare @cutoffdate date = DATEADD(DAY,-1,DATEADD(YEAR,30,@startdate));

WITH seq(n) AS 
(
  SELECT 0  --empieza en el cero '0'
  UNION ALL 
  SELECT n + 1 
  FROM seq 
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
)
SELECT n FROM seq
ORDER BY n 
OPTION (MAXRECURSION 0);


--A continuación, podemos añadir un segundo CTE 
--que traduzca esos números en todas las fechas de nuestro rango:

declare @startdate date = getdate()
declare @cutoffdate date = DATEADD(DAY,-1,DATEADD(YEAR,30,@startdate));

WITH seq(n) AS 
(
  SELECT 0  --empieza en el cero '0'
  UNION ALL 
  SELECT n + 1 
  FROM seq 
  WHERE n < DATEDIFF(DAY, @startdate, @cutoffdate)
),
d(d) as
(
select DATEADD(DAY,n,@startdate) from seq
)
select d from d
order by d
option (MAXRECURSION 0);

--Ahora, podemos empezar a ampliar esas fechas con información que suele ser vital
--para las tablas de calendario / dimensiones de fecha. 
--Hay mucha información que se puede extraer de la fecha, 
--pero es más conveniente tenerla disponible en una vista o tabla
--que hacer que cada consulta la calcule en línea.
--Estoy trabajando un poco hacia atrás aquí, 
--pero voy a crear un CTE intermedio para extraer exactamente una vez algunos cálculos
--que más tarde tendré que hacer varias veces. Esta consulta:


declare @startdate date = getdate()
declare @cutoffdate date = DATEADD(DAY,-1,DATEADD(YEAR,30,@startdate));

WITH seq(n) AS 
(
  SELECT 0  --empieza en el cero '0'
  UNION ALL 
  SELECT n + 1 
  FROM seq 
  WHERE n < DATEDIFF(DAY, @startdate, @cutoffdate)
),
d(d) as
(
select DATEADD(DAY,n,@startdate) from seq
),
src as
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
)
SELECT * FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);


--Sean cuales sean mis datos de origen,
--puedo basarme en esas partes y 
--obtener muchos más detalles sobre cada fecha:


declare @startdate date = getdate()
declare @cutoffdate date = DATEADD(DAY,-1,DATEADD(YEAR,30,@startdate));

WITH seq(n) AS 
(
  SELECT 0  --empieza en el cero '0'
  UNION ALL 
  SELECT n + 1 
  FROM seq 
  WHERE n < DATEDIFF(DAY, @startdate, @cutoffdate)
),
d(d) as
(
select DATEADD(DAY,n,@startdate) from seq
),
src as
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
),
dim AS
(
  SELECT
    TheDate, 
    TheDay,
    TheDaySuffix        = CONVERT(char(2), CASE WHEN TheDay / 10 = 1 THEN 'th' ELSE 
                            CASE RIGHT(TheDay, 1) WHEN '1' THEN 'st' WHEN '2' THEN 'nd' 
                            WHEN '3' THEN 'rd' ELSE 'th' END END),
    TheDayName,
    TheDayOfWeek,
    TheDayOfWeekInMonth = CONVERT(tinyint, ROW_NUMBER() OVER 
                            (PARTITION BY TheFirstOfMonth, TheDayOfWeek ORDER BY TheDate)),
    TheDayOfYear,
    IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7) 
                            THEN 1 ELSE 0 END,
    TheWeek,
    TheISOweek,
    TheFirstOfWeek      = DATEADD(DAY, 1 - TheDayOfWeek, TheDate),
    TheLastOfWeek       = DATEADD(DAY, 6, DATEADD(DAY, 1 - TheDayOfWeek, TheDate)),
    TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER 
                            (PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
    TheMonth,
    TheMonthName,
    TheFirstOfMonth,
    TheLastOfMonth      = MAX(TheDate) OVER (PARTITION BY TheYear, TheMonth),
    TheFirstOfNextMonth = DATEADD(MONTH, 1, TheFirstOfMonth),
    TheLastOfNextMonth  = DATEADD(DAY, -1, DATEADD(MONTH, 2, TheFirstOfMonth)),
    TheQuarter,
    TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheYear,
    TheISOYear          = TheYear - CASE WHEN TheMonth = 1 AND TheISOWeek > 51 THEN 1 
                            WHEN TheMonth = 12 AND TheISOWeek = 1  THEN -1 ELSE 0 END,      
    TheFirstOfYear      = DATEFROMPARTS(TheYear, 1,  1),
    TheLastOfYear,
    IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0) 
                            OR (TheYear % 4 = 0 AND TheYear % 100 <> 0) 
                            THEN 1 ELSE 0 END),
    Has53Weeks          = CASE WHEN DATEPART(WEEK,     TheLastOfYear) = 53 THEN 1 ELSE 0 END,
    Has53ISOWeeks       = CASE WHEN DATEPART(ISO_WEEK, TheLastOfYear) = 53 THEN 1 ELSE 0 END,
    MMYYYY              = CONVERT(char(2), CONVERT(char(8), TheDate, 101))
                          + CONVERT(char(4), TheYear),
    Style101            = CONVERT(char(10), TheDate, 101),
    Style103            = CONVERT(char(10), TheDate, 103),
    Style112            = CONVERT(char(8),  TheDate, 112),
    Style120            = CONVERT(char(10), TheDate, 120)
  FROM src
)
SELECT * FROM dim
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);


  --Esto añade información suplementaria sobre cualquier fecha dada,
  --como el primer período / último período en el que cae la fecha,
  --si es un año bisiesto, algunos formatos de cadena populares,
  --y algunos detalles específicos de ISO 8601 (hablaré más sobre ellos en otro consejo).
  --Puede que sólo quiera algunas de estas columnas, y puede que también quiera otras.
  --Cuando esté satisfecho con la salida, puede cambiar esta línea:

select * from dim --e la línea 369

--por esta:

select * into dbo.DateDimension from dim --en la línea 369


--A continuación, puede añadir una clave primaria agrupada
--(y cualquier otro índice que desee tener a mano):



CREATE UNIQUE CLUSTERED INDEX PK_DateDimension ON dbo.DateDimension(TheDate); --sale en rojo pq no lo he ejecutado aún



--A continuación, tenemos que hablar de los días festivos,
--una de las principales temporadas en las que es necesario utilizar
--una tabla de calendario en lugar de confiar en las funciones
--integradas de fecha/hora. En la versión original de este consejo,
--añadí una columna IsHoliday, pero como un comentario señaló con razón,
--este conjunto es probablemente mejor en una tabla separada:




CREATE TABLE dbo.HolidayDimension
(
  TheDate date NOT NULL,
  HolidayText nvarchar(255) NOT NULL,
  CONSTRAINT FK_DateDimension FOREIGN KEY(TheDate) REFERENCES dbo.DateDimension(TheDate) --llave foranea de la fecha de la tabla tiempo
);

CREATE CLUSTERED INDEX CIX_HolidayDimension ON dbo.HolidayDimension(TheDate);
GO

Esto le permite tener más de un día festivo para cualquier fecha, y de hecho permite múltiples calendarios completos cada uno con su propio conjunto de días festivos (imagine una columna adicional especificando el CalendarID).

--Rellenar la tabla de dimensiones de días festivos puede ser complejo.
--Como estoy en Estados Unidos, voy a tratar aquí los días festivos legales;
--por supuesto, si vive en otro país, tendrá que utilizar una lógica diferente.
--También tendrás que añadir los días festivos de tu empresa manualmente,
--pero si tienes cosas que son deterministas, como los días festivos, el Boxing Day,
--o el tercer lunes de julio es tu torneo anual de lucha libre,
--deberías ser capaz de hacer la mayor parte de eso sin mucho trabajo siguiendo
--el mismo tipo de patrón que utilizo a continuación.
--También es posible que tenga que añadir algo de lógica si su empresa
--celebra los días festivos del fin de semana en el día laborable anterior o posterior,
--lo que se vuelve aún más complejo si esos días coinciden
--con otros días no laborables específicos de la empresa o del sector.
--Podemos añadir la mayoría de los días festivos tradicionales con una sola pasada
--y criterios bastante simples:



--sale en rojo pq no lo he ejecutado, tengo que cambiar texto
;WITH x AS 
(
  SELECT
    TheDate,
    TheFirstOfYear,
    TheDayOfWeekInMonth, 
    TheMonth, 
    TheDayName, 
    TheDay,
    TheLastDayOfWeekInMonth = ROW_NUMBER() OVER 
    (
      PARTITION BY TheFirstOfMonth, TheDayOfWeek
      ORDER BY TheDate DESC
    )
  FROM dbo.DateDimension
),
s AS
(
  SELECT TheDate, HolidayText = CASE
  WHEN (TheDate = TheFirstOfYear) 
    THEN 'New Year''s Day'
  WHEN (TheDayOfWeekInMonth = 3 AND TheMonth = 1 AND TheDayName = 'Monday')
    THEN 'Martin Luther King Day'    -- (3rd Monday in January)
  WHEN (TheDayOfWeekInMonth = 3 AND TheMonth = 2 AND TheDayName = 'Monday')
    THEN 'President''s Day'          -- (3rd Monday in February)
  WHEN (TheLastDayOfWeekInMonth = 1 AND TheMonth = 5 AND TheDayName = 'Monday')
    THEN 'Memorial Day'              -- (last Monday in May)
  WHEN (TheMonth = 7 AND TheDay = 4)
    THEN 'Independence Day'          -- (July 4th)
  WHEN (TheDayOfWeekInMonth = 1 AND TheMonth = 9 AND TheDayName = 'Monday')
    THEN 'Labour Day'                -- (first Monday in September)
  WHEN (TheDayOfWeekInMonth = 2 AND TheMonth = 10 AND TheDayName = 'Monday')
    THEN 'Columbus Day'              -- Columbus Day (second Monday in October)
  WHEN (TheMonth = 11 AND TheDay = 11)
    THEN 'Veterans'' Day'            -- (November 11th)
  WHEN (TheDayOfWeekInMonth = 4 AND TheMonth = 11 AND TheDayName = 'Thursday')
    THEN 'Thanksgiving Day'          -- (Thanksgiving Day ()fourth Thursday in November)
  WHEN (TheMonth = 12 AND TheDay = 25)
    THEN 'Christmas Day'
  END
  FROM x
  WHERE 
    (TheDate = TheFirstOfYear)
    OR (TheDayOfWeekInMonth = 3     AND TheMonth = 1  AND TheDayName = 'Monday')
    OR (TheDayOfWeekInMonth = 3     AND TheMonth = 2  AND TheDayName = 'Monday')
    OR (TheLastDayOfWeekInMonth = 1 AND TheMonth = 5  AND TheDayName = 'Monday')
    OR (TheMonth = 7 AND TheDay = 4)
    OR (TheDayOfWeekInMonth = 1     AND TheMonth = 9  AND TheDayName = 'Monday')
    OR (TheDayOfWeekInMonth = 2     AND TheMonth = 10 AND TheDayName = 'Monday')
    OR (TheMonth = 11 AND TheDay = 11)
    OR (TheDayOfWeekInMonth = 4     AND TheMonth = 11 AND TheDayName = 'Thursday')
    OR (TheMonth = 12 AND TheDay = 25)
)
INSERT dbo.HolidayDimension(TheDate, HolidayText)
SELECT TheDate, HolidayText FROM s 
UNION ALL 
SELECT DATEADD(DAY, 1, TheDate), 'Black Friday'
  FROM s WHERE HolidayText = 'Thanksgiving Day'
ORDER BY TheDate;

--Por último, puede crear una vista que sirva
--de puente entre estas dos tablas (o varias vistas):



CREATE VIEW dbo.TheCalendar
AS 
  SELECT
    d.TheDate,
    d.TheDay,
    d.TheDaySuffix,
    d.TheDayName,
    d.TheDayOfWeek,
    d.TheDayOfWeekInMonth,
    d.TheDayOfYear,
    d.IsWeekend,
    d.TheWeek,
    d.TheISOweek,
    d.TheFirstOfWeek,
    d.TheLastOfWeek,
    d.TheWeekOfMonth,
    d.TheMonth,
    d.TheMonthName,
    d.TheFirstOfMonth,
    d.TheLastOfMonth,
    d.TheFirstOfNextMonth,
    d.TheLastOfNextMonth,
    d.TheQuarter,
    d.TheFirstOfQuarter,
    d.TheLastOfQuarter,
    d.TheYear,
    d.TheISOYear,
    d.TheFirstOfYear,
    d.TheLastOfYear,
    d.IsLeapYear,
    d.Has53Weeks,
    d.Has53ISOWeeks,
    d.MMYYYY,
    d.Style101,
    d.Style103,
    d.Style112,
    d.Style120,
    IsHoliday = CASE WHEN h.TheDate IS NOT NULL THEN 1 ELSE 0 END,
    h.HolidayText
  FROM dbo.DateDimension AS d
  LEFT OUTER JOIN dbo.HolidayDimension AS h
  ON d.TheDate = h.TheDate;

  --Y ahora dispone de una vista de calendario funcional que puede utilizar
  --para todas sus necesidades empresariales o de elaboración de informes

--TODO ESTE PROCESO ESTÁ EN ESTÁ WEB:
--https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/



--Resumen

--La creación de una dimensión o tabla de calendario para fechas de negocios
--y períodos fiscales puede parecer intimidante al principio,
--pero una vez que se tiene una metodología sólida en línea,
--puede valer mucho la pena. Hay muchas formas de hacerlo;
--algunos suscribirán la idea de que muchos de estos hechos relacionados con fechas
--pueden derivarse en tiempo de consulta, o al menos ser columnas computadas no persistentes.
--Tendrá que decidir si los valores se calculan
--con la frecuencia suficiente para justificar el espacio adicional en el disco y en el conjunto de búferes.

--Para mejorar aún más el rendimiento,
--puede colocar la tabla de calendario en su propio grupo de archivos 
--(o en su propia base de datos) y marcarla como de sólo lectura después de la población inicial. 
--Esto no forzará a la tabla a permanecer en memoria todo el tiempo (¿recuerda DBCC PINTABLE?),
--pero eso ocurrirá de forma natural si la tabla se consulta lo suficiente.
--Lo que podría ayudar es a reducir otros tipos de contención.



-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--Add and Subtract Dates using DATEADD in SQL Server--

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

declare @date datetime = getdate()

select DATEADD(MINUTE,15,@date) as addminutos
select DATEADD(HOUR,-1,@date) as subshoras


select DATEADD(WEEKDAY,-1,@date) as addweekday
select DATEADD(WEEK,1,@date) as addweek

select DATEADD(DAY,3,@date) as addday
select DATEADD(DAYOFYEAR,2,@date) as adddayofyear

select DATEADD(MONTH,3,@date) as addmonth
select DATEADD(QUARTER,2,@date) as addquater
select DATEADD(YEAR,3,@date) as addyear


--A continuación también estamos utilizando la función DATEDIFF para encontrar la diferencia
--entre la hora de inicio y la hora final en segundos,
--y luego sumar el número de segundos al 01/01/1900,
--que se puede representar como un 0.

declare @startTime datetime = '2011-09-23T15:00:00'
declare @EndTime datetime = '2011-09-23T17:54:02'

--La función DATEDIFF(SECOND, @StartTime, @EndTime)
--calcula la diferencia en segundos entre @StartTime y @EndTime.

select DATEDIFF(SECOND,@startTime,@EndTime) --10442 segundos

--Luego, se utiliza DATEADD(SECOND, ...) para agregar esta cantidad de segundos a una fecha base.
--La fecha base es ‘1900-01-01 00:00:00’ (representada como 0 en segundos).
--El resultado de DATEADD es un nuevo valor DATETIME.

select DATEADD(SECOND,DATEDIFF(SECOND,@startTime,@EndTime),0) --1900-01-01 02:54:02.000


--Finalmente, se utiliza CONVERT(VARCHAR(8), ..., 108)
--para convertir el resultado en un formato de hora (HH:MM:SS).
--El código 108 especifica el formato de hora en HH:MM:SS.

--En resumen, la consulta calcula la diferencia en segundos entre @StartTime y @EndTime,
--y luego muestra esta diferencia en formato de hora (HH:MM:SS).

select CONVERT(varchar(8),DATEADD(SECOND,DATEDIFF(SECOND,@startTime,@EndTime),0),108)


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--Otro uso sería cuando se recuperan datos basados en un periodo.
--El procedimiento podría introducir una fecha de inicio
--y un número de días para recuperar los datos.


select * from Production.WorkOrder

select distinct StartDate
from Production.WorkOrder
order by StartDate desc

select MIN(StartDate) from Production.WorkOrder
select MAX(StartDate) from Production.WorkOrder

--2014-04-01 00:00:00.000

declare @startDate datetime = '2014-04-01 00:00:00.000'
declare @units int = 7
--select DATEADD(DAY,@units,@startDate) --2014-01-11 00:00:00.000
select  distinct *
from Production.WorkOrder
where StartDate between @startDate and DATEADD(DAY,@units,@startDate) --2014-01-11 00:00:00.000

--En otras palabras, busca registros cuya fecha de inicio está dentro de un rango de 7 días
--a partir de la fecha inicial.

--En resumen, esta consulta devuelve todas las órdenes de trabajo cuya fecha
--de inicio está dentro de una ventana de 7 días a partir del 1 de abril de 2014.
--Si ejecutamos esta consulta, obtendremos los registros que cumplen con esta condición


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--SQL Server Date and Time Functions with Examples

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--Función DATENAME de SQL Server

--DATENAME - Devuelve una cadena correspondiente al datepart especificado
--para la fecha dada como se muestra en la siguiente tabla


-- date and time parts - returns nvarchar 
SELECT DATENAME(YEAR, GETDATE())        AS 'Year';        
SELECT DATENAME(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATENAME(MONTH, GETDATE())       AS 'Month Name';       
SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATENAME(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'Day of the Week';     
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';        
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATENAME(SECOND, GETDATE())      AS 'Second';      
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';



-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--Función DATEPART de SQL Server

--DATEPART - devuelve un entero correspondiente al datepart especificado

-- date and time parts - returns int
SELECT DATEPART(YEAR, GETDATE())        AS 'Year';        
SELECT DATEPART(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATEPART(MONTH, GETDATE())       AS 'Month';       
SELECT DATEPART(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATEPART(DAY, GETDATE())         AS 'Day';         
SELECT DATEPART(WEEK, GETDATE())        AS 'Week';        
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'WeekDay';     
SELECT DATEPART(HOUR, GETDATE())        AS 'Hour';        
SELECT DATEPART(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATEPART(SECOND, GETDATE())      AS 'Second';      
SELECT DATEPART(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATEPART(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATEPART(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATEPART(ISO_WEEK, GETDATE())    AS 'Week'; 

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--Funciones DAY, MONTH y YEAR de SQL Server

--DAY - devuelve un entero correspondiente al día especificado
--MES - devuelve un número entero correspondiente al mes especificado
--AÑO - devuelve un número entero correspondiente al año especificado

SELECT DAY(GETDATE())   AS 'Day';                            
SELECT MONTH(GETDATE()) AS 'Month';                       
SELECT YEAR(GETDATE())  AS 'Year';

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--Funciones DATEFROMPARTS, DATETIME2FROMPARTS, DATETIMEFROMPARTS, DATETIMEOFFSETFROMPARTS, SMALLDATETIMEFROMPARTS y TIMEFROMPARTS de SQL Server

--    DATEFROMPARTS - devuelve una fecha a partir de la fecha especificada
--    DATETIME2FROMPARTS - devuelve una datetime2 a partir de la parte especificada
--    DATETIMEFROMPARTS - devuelve una fecha y hora a partir de la parte especificada
--    DATETIMEOFFSETFROMPARTS - devuelve una fecha y hora a partir de la parte especificada
--    SMALLDATETIMEFROMPARTS - devuelve un smalldatetime de la parte especificada
--    TIMEFROMPARTS - devuelve la hora de la parte especificada



-- date and time from parts
SELECT DATEFROMPARTS(2019,1,1)                         AS 'Date';          -- returns date
SELECT DATETIME2FROMPARTS(2019,1,1,6,0,0,0,1)          AS 'DateTime2';     -- returns datetime2
SELECT DATETIMEFROMPARTS(2019,1,1,6,0,0,0)             AS 'DateTime';      -- returns datetime
SELECT DATETIMEOFFSETFROMPARTS(2019,1,1,6,0,0,0,0,0,0) AS 'Offset';        -- returns datetimeoffset
SELECT SMALLDATETIMEFROMPARTS(2019,1,1,6,0)            AS 'SmallDateTime'; -- returns smalldatetime
SELECT TIMEFROMPARTS(6,0,0,0,0)                        AS 'Time';          -- returns time


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--Funciones DATEDIFF y DATEDIFF_BIG de SQL Server

-- DATEDIFF - devuelve el número de límites de fecha u hora cruzados entre fechas especificadas como un int
-- DATEDIFF_BIG - devuelve el número de límites de fecha u hora cruzados entre fechas especificadas como bigint



--Date and Time Difference
SELECT DATEDIFF(DAY, 2019-31-01, 2019-01-01)      AS 'DateDif'    -- returns int
SELECT DATEDIFF_BIG(DAY, 2019-31-01, 2019-01-01)  AS 'DateDifBig' -- returns bigint


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--Funciones DATEADD, EOMONTH, SWITCHOFFSET y TODATETIMEOFFSET de SQL Server

--    DATEADD - devuelve datepart con intervalo añadido como datetime
--    EOMONTH - devuelve el último día del mes del intervalo como tipo de fecha_inicial
--    SWITCHOFFSET - devuelve el desfase de fecha y hora y el desfase de zona horaria
--    TODATETIMEOFFSET - devuelve fecha y hora con desfase de zona horaria




-- modify date and time
SELECT DATEADD(DAY,1,GETDATE())        AS 'DatePlus1';          -- returns data type of the date argument
SELECT EOMONTH(GETDATE(),1)            AS 'LastDayOfNextMonth'; -- returns start_date argument or date
SELECT SWITCHOFFSET(GETDATE(), -6)     AS 'NowMinus6';          -- returns datetimeoffset
SELECT TODATETIMEOFFSET(GETDATE(), -2) AS 'Offset';             -- returns datetimeoffset

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------


--Función ISDATE de SQL Server para Validar Valores de Fecha y Hora

--   ISDATE - devuelve int - Devuelve 1 si es un tipo de fecha/hora válido y 0 si no lo es


-- validate date and time - returns int
SELECT ISDATE(GETDATE()) AS 'IsDate'; 
SELECT ISDATE(NULL) AS 'IsDate';






