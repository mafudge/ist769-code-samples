-- order details is some complictated data logic. 
select  c.customer_email, c.customer_firstname, c.customer_lastname,
		o.*, 
		p.product_id, p.product_name, p.product_retail_price, 
		od.order_qty, p.product_retail_price * od.order_qty as ext_price
	from fudgemart_products p 
		join fudgemart_order_details od on od.product_id=p.product_id
		join fudgemart_orders o on od.order_id = o.order_id
		join fudgemart_customers c on c.customer_id=o.customer_id

GO

-- let's simplify things by abstracting this into a view
if exists(select * from sys.objects where name = 'v_order_details')
	drop view v_order_details
go
create view v_order_details
as
	select  c.customer_email, c.customer_firstname, c.customer_lastname,
			o.*, 
			p.product_id, p.product_name, p.product_retail_price, 
			od.order_qty, p.product_retail_price * od.order_qty as ext_price
		from fudgemart_products p 
			join fudgemart_order_details od on od.product_id=p.product_id
			join fudgemart_orders o on od.order_id = o.order_id
			join fudgemart_customers c on c.customer_id=o.customer_id
go

-- let's use it! to view the details of order 1 
select * from v_order_details where order_id = 1

-- and find it in INFORMATION_SCHEMA
select * from INFORMATION_SCHEMA.VIEWS 
