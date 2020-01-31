-- same example, but as a table-valued function.
if exists(select * from sys.objects where name = 'f_order_details')
	drop function f_order_details
go
create function dbo.f_order_details
(
	@order_id as int 
) returns table as
return (
	select  c.customer_email, c.customer_firstname, c.customer_lastname,
			o.*, 
			p.product_id, p.product_name, p.product_retail_price, 
			od.order_qty, p.product_retail_price * od.order_qty as ext_price
		from fudgemart_products p 
			join fudgemart_order_details od on od.product_id=p.product_id
			join fudgemart_orders o on od.order_id = o.order_id
			join fudgemart_customers c on c.customer_id=o.customer_id
		where o.order_id = @order_id 
)

go
-- entire order detail of order 1. makes a bit more sense as a table valued function.
select * from dbo.f_order_details(5) 

-- can join, even though in this example its silly to do so
select d.*,p.product_department 
	from dbo.f_order_details(1) d 
		join fudgemart_products p on d.product_id = p.product_id
	
