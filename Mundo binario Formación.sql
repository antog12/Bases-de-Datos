
--CONCATENAR Y ALIAS--

/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Person]


  select [p].FirstName +' '+ [p].LastName as Nombrecompleto --de las dos maneras vale
  from [AdventureWorks2019].[Person].[Person] as [p]

   select concat([p].FirstName,' ', [p].LastName, '/', [p].EmailPromotion) as Nombrecompleto2
  from [AdventureWorks2019].[Person].[Person] as [p]

  --cuando se concatena, si concateno un string con un int por ejemplo, con un cast convertimos el int en varchar para esta consulta.

  ------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------
  --VAMOS A VER TOP Y DISTINC

  select top(5) * from AdventureWorks2019.Person.Person
  order by Person.ModifiedDate asc

  select top 20 percent * from AdventureWorks2019.Person.Person -- secciono el 20% de la los datos que quiera
  order by Person.ModifiedDate asc

  --dsitinc( obtengo registros los cuales no se repiten)

  select * from AdventureWorks2019.Person.Person

  select distinct FirstName from AdventureWorks2019.Person.Person

  ------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------

  --CASE, ISNULL, COALESCE en SQL Server


select pod.ProductID, 
		pod.UnitPrice,
		case
			when pod.UnitPrice <= 25 then pod.ReceivedQty
			when pod.UnitPrice > 25 and pod.UnitPrice <=40 then pod.RejectedQty
			when pod.UnitPrice > 40 and pod.UnitPrice <=60 then pod.StockedQty
			else
				0 --cuando salga este error: "Error converting data type varchar to numeric.", poner el elese a "0".
			
		end as 'Status', -- este es el nombre que le pongo a la columna
		pod.ReceivedQty,
		pod.RejectedQty,
		pod.StockedQty
		
from 
Purchasing.PurchaseOrderDetail as [pod]

--VAMOS A VER EL ISNULL

select 
	v.AccountNumber,
	v.Name,
	isnull(v.PurchasingWebServiceURL, 'por defecto') as PurchasingWebServiceURL  --si es nulo, le pongo un nombre por defecto o lo dejo vacio

from AdventureWorks2019.Purchasing.Vendor as v

--VAMOS A VER EL COALESCE (ejemplo de la tabla production.product)

declare @x varchar(5)
declare @y varchar(10)

set @x = NULL
set @y = 1234567890

select coalesce(@x,@y) as [coalesce] -- si el primero es nulo, coge el ss valor
select ISNULL(@x,@y) as[isnull]


select 
	p.ProductID,
	p.Name,
	p.Size,
	p.SizeUnitMeasureCode,
	p.WeightUnitMeasureCode,
	p.Weight,
	coalesce(p.Size, p.SizeUnitMeasureCode, p.WeightUnitMeasureCode, 'default') as 'size'

from Production.Product as [p]
where p.ProductID= 507

--con colaesce , nos va a coger el siguiente valor mientras haya nulos y sino,
--puedo poner un por defecto por ejemplo.









