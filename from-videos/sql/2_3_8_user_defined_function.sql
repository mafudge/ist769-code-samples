use fudgemart_v3
go

drop function dbo.f_customer_order_count
go 

-- what does a count of customer orders look like
declare @customer_id int
set @customer_id = 1
select count(*) from fudgemart_orders where customer_id = @customer_id
go

-- let's turn this logic into a function
create function dbo.f_customer_order_count(
	@customer_id int --input
	) RETURNS int AS
BEGIN
	declare @count int
	set @count = (select count(*) from fudgemart_v3.dbo.fudgemart_orders where customer_id=@customer_id)
	RETURN @count -- output
END
GO

-- call it in a seleect statement
select customer_id, customer_firstname, customer_lastname, 
	dbo.f_customer_order_count(customer_id)  as order_count
	from  fudgemart_customers

-- more proof its correct
select count(*) from fudgemart_orders where customer_id = 1

-- This is useful, let's alter the table and add it as a calculated column
alter table fudgemart_customers add
	customer_order_count as dbo.f_customer_order_count(customer_id)

-- all customers, now with calculated column
select * from fudgemart_customers

