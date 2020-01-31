update fudgemart_products set product_is_active = 1 - product_is_active where product_id = 1
select * from fudgemart_products where product_id=1

if exists(select * from sys.objects where name = 'p_toggle_product_activation')
	drop procedure p_toggle_product_activation
go
create procedure p_toggle_product_activation(
	@product_id int
) as
begin
	declare @current_status as bit
	update fudgemart_products set product_is_active = 1 - product_is_active where product_id = @product_id
	set @current_status = (select product_is_active from fudgemart_products where product_id=@product_id)
	return @current_status
end
go

declare @result bit
exec @result =p_toggle_product_activation 1 
print @result

