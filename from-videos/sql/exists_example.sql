select c.* from fudgemart_customers c where 
	exists(select * from fudgemart_orders o where o.customer_id= c.customer_id)

-- equivalent to
select c.* from fudgemart_customers c 
	join fudgemart_orders o on c.customer_id=o.customer_id
	
