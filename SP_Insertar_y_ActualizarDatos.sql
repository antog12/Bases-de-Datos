create database bodega

use bodega

create table producto
(
idprod char(7) primary key not null,
descripcion varchar(25),
existencias int,
precio decimal(10,2),
preciov decimal(10,2),
ganancia as preciov-precio,
check(preciov>precio)
)
go

create table pedido
(
idpedido char(7),
idprod char(7),
cantidad int,
foreign key (idprod) references producto(idprod)
)


insert into producto values('P1', 'Coca Cola',10,5,10)
insert into pedido values ('PD1', 'P1',5)
select * from producto
select * from pedido

create procedure SP_insertar_producto--parámetros en el mismo orden que la tabla
@idProducto char(7),
@descripción varchar(25),
@existencias int,
@precio decimal(10,2),
@preciov decimal(10,2)
as
declare @total int --contador de resultados(lo usamos para ver si existe el prod o no)
select @total=count(idprod) from producto where idprod = @idProducto or descripcion=@descripción-- cuando idprod sea = al idprod queremos ingresar o su descripción
if(@total<1)-- es decir, sino ha encontrado resultados
	begin
		insert into producto values(@idProducto,@descripción,@existencias,@precio,@preciov)

	end
else--de lo contrario
	begin
		print 'ESTE PRODUCTO YA HA SIDO INGRESADO'
	end

--EJECUTAMOS EL SP

exec SP_insertar_producto 'P3', 'Pepsi', 15, 20,30

------------------------------
------------------------------
--Ejercicio 2. Insertar pedidos

create procedure SP_insertar_pedido
@idpedido char(7),
@idprod char(7),
@cantidad int
as
declare @total int --contador de resultados
declare @exist int --existencias que tenga el producto
declare @nuevaCantidad int --resta de la cantidad que estemos haciendo del pedido respecto a las existencias del producto
select @total=count(idpedido) from pedido where idpedido=@idpedido  --vemos si existe ese pedido
if(@total<1)--no se encuentran resultados
	begin
		select @total=count(idprod) from producto where idprod=@idprod --vamos a verificar que el producto exista
		if(@total>=1)--se encontraron resultados
		begin
			select @exist = existencias from producto where idprod=@idprod --vamos a validar las existencias de ese producto
			set @nuevaCantidad = @exist-@cantidad --obtenemos la nueva cantidad
			if(@nuevaCantidad>=0) --hay stock suficiente para ha cer el pedido
				begin
					insert into pedido values(@idpedido,@idprod,@cantidad)
					update producto set existencias = @nuevaCantidad where idprod=@idprod --actualizo las existencias una vez hecho el pedido
				end
			else
				begin
					print 'EXISTENCIA DEL PRODUCTO INSUFICIENTE'
				end
			end
		else
			begin
				print 'ESTE PRODUCTO NO EXISTE'
			end
	end
else
	begin
		print 'YA EXISTE UN PEDIDO CON ESE ID'
	end

exec SP_insertar_pedido 'PD3','P3',5

select * from producto
select * from pedido