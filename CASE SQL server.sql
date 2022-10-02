--Consultas SQL en SQL_SERVER

--CASE

SELECT [name],CASE
				WHEN ListPrice <200 THEN 'barato'
				WHEN ListPrice <500 THEN 'medio'
				WHEN ListPrice >500 THEN 'caro'
				END as Precio, CASE
								 WHEN Weight <200 THEN 'ligero'
								 WHEN Weight <500 THEN 'medio'
								 WHEN Weight is null THEN 'no definido'
								 ELSE 'pesado'
								 END as peso ,CASE FinishedGoodsFlag 
									WHEN 0 THEN 'no disponible'
									WHEN 1 THEN 'Disponible'
									END as Estado
FROM Production.Product

