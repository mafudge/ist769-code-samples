if exists(select * from sys.objects where name ='f_customer_status')
begin
	drop function dbo.f_customer_status
end
go

create function dbo.f_customer_status( @customer_id int)
returns varchar(max) as 
begin
	declare @result varchar(max)
	if exists(select* from fudgemart_customers where customer_order_count > 140 and customer_id =@customer_id)
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
select dbo.customer_status(customer_id), customer_firstname from fudgemart_customers

select @@rowcount 