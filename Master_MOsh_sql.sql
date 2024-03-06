use mosh_sql_store;

/*recuperar datos*/

select * from customers
where customer_id > 5
order by first_name;

select distinct state from customers;

/*return all the products name, unit price, new price (unit price *1.1) */
select * from products;

select name,unit_price,(unit_price*1.1) as new_price
from products;

/*get the orders placed this year*/

select max(order_date) from orders;
select * from orders
where order_date>='2019-01-30';

select * from customers;

select * from customers
where birth_date > '1990-01-01' and points > 1000;

select * from customers
where not (birth_date > '1990-01-01' and points > 1000);

/*
get items of order #6 where total price is greater than 30 
*/

select * from order_items;

select * from order_items
where order_id=6 and quantity*unit_price>30;
/*return products with quanity in stock equal to 49, 38, 72*/
select * from customers;

select * from customers
where state in ('VA','GA','FL');

select * from customers
where state not in ('VA','GA','FL');


/*return products with quanity in stock equal to 49, 38, 72*/
select * from products;

select * from products
where quantity_in_stock in(49,38,72);

select * from customers
where points
between 1000 and 3000;

/*return customers born between 1/1/1990 and 1/1/2000*/

select * from customers
where birth_date between '1990-01-01' AND '2000-01-01';

/*get the orders that are not shipped*/

select * from orders
where shipped_date is null;

select * from customers
order by last_name desc, state asc
limit 10;

select order_id, product_id,quantity,unit_price
from order_items
where order_id = 2;

/* offset start from 2nd record */

select order_id, product_id,quantity,unit_price
from order_items
limit 5 offset 2;

/*customer 5 records start from 6 for pagniation (example 1-5 for one page, 6-10 for second page...)*/

select * from customers
limit 5,6;

/*get top 3 loyal customers*/

select * from customers
order by points desc
limit 3;

/*
	% 		any number of characters
    _		single character
*/

select * from customers
where last_name like '_____y';

SELECT *
FROM customers
WHERE last_name LIKE 'b____y';

/*get customers addresses contain TRAIL or AVENUE OR phone numbers end with 9*/

select * from customers
where address like '%TRAIL%' or address like '%AVENUE%'
or phone like '%9';

SELECT *
FROM customers
WHERE address REGEXP 'trail|avenue';

SELECT *
FROM customers
WHERE phone REGEXP '9$';

/******************************************/
/*       JOINS                            */
/******************************************/

use mosh_sql_store;

select * from order_items;
select * from products;

select oi.order_id, p.name,oi.quantity,oi.unit_price
from order_items oi
inner join products p
on p.product_id=oi.order_id;

/******************************************/
/*       SELF JOINS                       */
/******************************************/

USE mosh_sql_hr;

select * from employees
limit 5;

select * from offices;

select e1.employee_id, e1.first_name, e1.
last_name,
coalesce(concat(e2.first_name, e2.last_name),'Top manager') as manager
from employees e1
left join employees e2
on e1.reports_to=e2.employee_id;


/******************************************/
/*       Joining Multiple Tables          */
/******************************************/
use mosh_sql_store;

select * from customers;
select * from orders;
select * from order_statuses;

select o.order_id, o.order_date,c.first_name,c.last_name,os.name
from orders o
join customers c on c.customer_id=o.customer_id
join order_statuses os on os.order_status_id = o.status;

/*payment and customer details*/
USE mosh_sql_invoicing;

select * from clients;
select * from payment_methods;
select * from payments;

select c.client_id, c.name, p.invoice_id, p.date, p.amount, pm.name
from payments p
join payment_methods pm on pm.payment_method_id=p.payment_method
join clients c on c.client_id=p.client_id;

/******************************************/
/*       Implicit Join                    */
/******************************************/

select c.client_id, c.name, p.invoice_id, p.date, p.amount, pm.name
from payments p, payment_methods pm, clients c
where pm.payment_method_id=p.payment_method
and c.client_id=p.client_id;

USE mosh_sql_store;

SELECT c.customer_id, c.first_name,c.last_name,o.order_id
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY 1;

SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id;

SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

/******************************************/
/*       USING                            */
/******************************************/

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING(order_id,product_id);


USE mosh_sql_invoicing;

SELECT p.date, c.name, p.amount, pm.name
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm ON pm.payment_method_id = p.payment_method;







