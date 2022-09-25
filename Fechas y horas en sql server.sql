--gran precisi�n ( sobre todo en proyectos internacionales)

select SYSDATETIME() as 'SYSDATETIME'
select SYSUTCDATETIME() as 'SYSUTCDATETIME'
select SYSDATETIMEOFFSET() as 'SYSDATETIMEOFFSET'

--Baja precisi�n ( los proyectos que suelo manejar)

select GETDATE() as 'GETDATE'
select CURRENT_TIMESTAMP as 'CURRENT_TIMESTAMP'
select GETUTCDATE() as 'GETUTCDATE'

--obtener partes de la fecha-----------------------------------

--con datepart extraigo la parte que me interese de una fecha(a�o, mes ,d�a,etc..)

select DATEPART(year,getdate())  --selecciono el a�o de la fecha actual

select DATEPART(year,[ModifiedDate]) as a�o from Sales.CreditCard
order by a�o desc

select DATEPART(MONTH,getdate())

select DATEPART(MONTH,[ModifiedDate]) as month from Sales.CreditCard

--vamos a obtener el nombre del mes-----------------------------

select DATENAME(MONTH,getdate())

select DATENAME(MONTH,[ModifiedDate]) as month from Sales.CreditCard

---obtener la semana en la que estamos---

select DATENAME(WEEK,getdate())

select DATENAME(week,[ModifiedDate]) as month from Sales.CreditCard

--dia de la semana-------

select DATENAME(WEEKDAY,getdate())

select DATENAME(WEEKDAY,[ModifiedDate]) as month from Sales.CreditCard

--obtener la diferencia entre dos valores---

select datediff(day,'2022-09-01',getdate()) as diasTrascurridos  --lo podemos hacer con meses y a�os y d�as, etc..

--modify data---

select GETDATE() +1 --le sumo un d�a a la fecha actual
select GETDATE() -1

--vamos a alterar horas o d�as espec�ficos.--

select DATEADD(day,1,GETDATE()) --pero con esta funci�n puedo cambiar, d�as, horas, semanas, a�os, etc...Puedo sumar y restar

--vamos a obtener el �ltimo d�a del mes--

select EOMONTH(getdate())

select EOMONTH([ModifiedDate]) from Sales.CreditCard

--Validaci�n. Es para validar si una fecha es correcta o no. 1 es true 0 es false

select ISDATE(getdate()) as 'Validation'
select ISDATE('dfdfdfd') as 'Validation'

--para saber en que idioma est� connfigurado la BBDD--

select @@LANGUAGE

set language 'Spanish'
set language 'English'










