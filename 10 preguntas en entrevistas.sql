Use Pruebas

CREATE TABLE #INFORMATION

( SER_NO INT IDENTITY(1,1) PRIMARY KEY,

 EMP_NAME VARCHAR(25),

 SECTION VARCHAR(20),

 CONTACT_INFO BIGINT NOT NULL,

 LOCATION VARCHAR(15)

 )


  INSERT INTO #INFORMATION VALUES('Susheel','MANAGER',1111222211,'GAZIABAD'),

								('Vanya','MARKETING',1111222212,'Noida'),

								('Mohit','IT',1111222213,'Unnao'),

								('Prabhu','MANAGER',1111222214,'NOIDA'),

								('Vaibhav','SALES',1111222215,'Lucknow'),

								('Rahul','IT',1111222216,'KANPUR'),

								('Vaibhav','SALES',1111222215,'Lucknow'),

								('Vanya','MARKETING',1111222212,'Noida')


select * from #INFORMATION


--1.ENCONTRAR DUPLICADOS

;WITH cte 
AS 
(
SELECT EMP_NAME,SECTION,CONTACT_INFO,LOCATION, 

       ROW_NUMBER() OVER (PARTITION BY EMP_NAME,SECTION,CONTACT_INFO,LOCATION 

	                      ORDER BY EMP_NAME,SECTION,CONTACT_INFO,LOCATION ) AS DUPLICADOS
FROM #INFORMATION 
)
select * from cte WHERE DUPLICADOS>1;


--2.COMO ELIMINAR LOS DUPLICADOS

;WITH cte 
AS 
(
SELECT EMP_NAME,SECTION,CONTACT_INFO,LOCATION, 

       ROW_NUMBER() OVER (PARTITION BY EMP_NAME,SECTION,CONTACT_INFO,LOCATION 
	                     ORDER BY EMP_NAME,SECTION,CONTACT_INFO,LOCATION ) rw
FROM #INFORMATION 
)
DELETE from cte WHERE rw>1;


Select * FROM #INFORMATION 


------------3. Union & Union ALL


CREATE TABLE #INFORMATION1

( SER_NO INT IDENTITY(1,1) PRIMARY KEY,

 EMP_NAME VARCHAR(25),

 SECTION VARCHAR(20),

 CONTACT_INFO BIGINT NOT NULL,

 LOCATION VARCHAR(15)

 )

 INSERT INTO #INFORMATION1 VALUES('Susheel','MANAGER',1111222211,'GAZIABAD'),

								('Vanya','MARKETING',1111222212,'Noida'),

								('Mohit','IT',1111222213,'Unnao'),

								('Prabhu','MANAGER',1111222214,'NOIDA'),

								('Vaibhav','SALES',1111222215,'Lucknow'),

								('Rahul','IT',1111222216,'KANPUR'),

								('Vaibhav','SALES',1111222215,'Lucknow'),

								('Vanya','MARKETING',1111222212,'Noida')


-----no devuelve duplicados
Select * FROM #INFORMATION
UNION 
SELECT * FROM #INFORMATION1
-----devuelve duplicados
Select * FROM #INFORMATION
UNION ALL
SELECT * FROM #INFORMATION1


-----------4. RANK, dense_rank, row_number

Select *,row_number() over (order By EMP_NAME) AS RW_NUM, DENSE_RANK() over (order By EMP_NAME)
AS denserank,RANK() over (order By EMP_NAME) AS rank
FROM #INFORMATION1


------------5. Employee



CREATE TABLE #EMP

(

EMPID INT,

EMPName Varchar(100),

ManagerId Int,

Salary Int

)



Insert INTO #EMP values (68319,'Susheel','',6000),(66928,'Vaibhav',68319,2750),(67832,'Sumit',68319,2550),(67858,'Ram',67832,2750)

SELECT *

FROM #EMP

SELECT *

FROM #EMP w,

     #EMP m

WHERE w.managerid = m.empid

  AND w.salary> m.salary;