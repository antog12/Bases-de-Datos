use Pruebas
select * from FIFA

--encontrar el último ID

select MAX(ID)
from FIFA


--remover duplicados de una tabla

select distinct * 
from FIFA


select ID, Nombre,Club,ValorEuropa,COUNT(*) 
from FIFA
group by ID, Nombre,Club,ValorEuropa
having COUNT(*) > 1 --Las filas con un recuento superior a 1 son duplicados.

with duplicados as (
	select *,
		ROW_NUMBER() over (partition by ID,
		Nombre,Club,ValorEuropa order by (Select 0)) as rn
		from FIFA)

delete from duplicados where rn>1

--JOINS--

create table Employee2(
id int primary key not null,
name varchar(50),
department_id int not null

)

insert into Employee2(id,name,department_id)
values(1,'Alice',101)
insert into Employee2(id,name,department_id)
values(2,'Bob',102)
insert into Employee2(id,name,department_id)
values(3,'Charlie',101)
insert into Employee2(id,name,department_id)
values(4,'David',103)


create table Departments2(
id int primary key not null,
department_id int not null

)

insert into Departments2(id,department_id)
values (101,'HR')
insert into Departments2(id,department_id)
values (102,'IT')
insert into Departments2(id,department_id)
values (103,'Marketing')
insert into Departments2(id,department_id)
values (104,'Sales')


select * from Employee2
select * from Departments2


--Devuelve sólo las filas con valores coincidentes en ambas tablas.

select e.name, d.department_id
from Employee2 e
inner join Departments2 d
on e.department_id = d.id

--Devuelve todas las filas de la tabla izquierda
--y las filas coincidentes de la tabla derecha
--derecha.
--# Si no hay coincidencias en la tabla derecha,
--se devuelven valores NULL.

select e.name, d.department_id
from Employee2 e
left join Departments2 d
on e.department_id = d.id


--Devuelve todas las filas de la tabla derecha y
--las filas coincidentes de la tabla izquierda
--izquierda. 
--Si no hay coincidencias en la tabla izquierda,
--se devuelven valores NULL.

select isnull(e.name,'Vacio'), d.department_id
from Employee2 e
right join Departments2 d
on e.department_id = d.id

--Devuelve todas las filas cuando hay una coincidencia
--en la tabla izquierda o derecha.
--" Incluye las filas sin coincidencia en ninguna
--de las dos tablas con valores NULL.


select e.name, d.department_id
from Employee2 e
full outer join Departments2 d
on e.department_id = d.id



--Combina filas de una misma tabla,
--tratándola como dos tablas separadas.
--Suele utilizarse para datos jerárquicos.

select e1.name, e2.name as 'Manager'
from Employee2 e1
left join Employee2 e2
on e1.department_id = e2.id

--Diferencias Having y where y Group By

select * from Employee
select * from Department

select d.dept_name,AVG(e.salary) as 'Media Salario'
from Employee e
inner join Department d
on d.dept_id=e.dept_id
group by d.dept_name

select d.dept_name,AVG(e.salary) as 'Media Salario'
from Employee e
inner join Department d
on d.dept_id=e.dept_id
group by d.dept_name
having  AVG(e.salary) > 65







