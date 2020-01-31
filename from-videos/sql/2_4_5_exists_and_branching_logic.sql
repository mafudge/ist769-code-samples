-- let's implement some data logic for "customer_status"
-- note you must have the derived column from example 2_3_8
-- "gold" customers have more than 140 orders

create function dbo.customer_status( @customer_id int)
returns varchar(max) as 
begin
	declare @result varchar(max)
	if exists(select* from fudgemart_customers 
		where customer_order_count > 140 and customer_id =@customer_id)
	begin
		set @result = 'gold'
	end
	else
	begin
		set @result= 'regular'
	end
	return @result
End
go

-- Try it out!!!
select customer_id, customer_firstname, customer_lastname, dbo.customer_status(customer_id) 
	from fudgemart_customers

-- drop it if it exists
if exists(select * from sys.objects where name ='customer_status')
begin
	drop function dbo.customer_status
end
go
-- before we re-create it!
create function dbo.customer_status( @customer_id int)
returns varchar(max) as 
begin
	declare @result varchar(max)
	if exists(select* from fudgemart_customers where customer_order_count > 150 
		and customer_id =@customer_id)
	begin
		set @result = 'gold'
	end
	else
	begin
		set @result= 'regular'
	end
	return @result
end
go

-- Try it out!!!
select customer_id, customer_firstname, customer_lastname, dbo.customer_status(customer_id) 
from fudgemart_customers