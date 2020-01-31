set statistics io off
set statistics time off

select * from fudgemart_products

select product_name, product_retail_price 
	from fudgemart_products 
	where product_department in ('Clothing', 'Housewares')

select product_name, product_retail_price 
	from fudgemart_products 
	where product_department in ('Clothing', 'Housewares')
		and product_retail_price < (select avg(product_retail_price) from fudgemart_products)
	
select product_name, product_retail_price, od.order_qty, od.order_qty * product_retail_price as extended_price
	from fudgemart_products p 
		join fudgemart_order_details od on p.product_id= od.product_id
	where product_department in ('Clothing', 'Housewares')
		and product_retail_price < (select avg(product_retail_price) from fudgemart_products)
	order by product_name 

select product_name, sum(od.order_qty * product_retail_price) as total_amount_sold, 
		sum(od.order_qty) as total_qty, count(distinct od.order_id) as order_count
	from fudgemart_products p 
		join fudgemart_order_details od on p.product_id= od.product_id
	where product_department in ('Clothing', 'Housewares')
		and product_retail_price < (select avg(product_retail_price) from fudgemart_products)
	group by product_name
	order by product_name 


select * from fudgemart_employee_timesheets