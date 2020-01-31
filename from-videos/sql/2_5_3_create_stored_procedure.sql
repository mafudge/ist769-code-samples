-- Creating data logic as a stored procedure
--FIRST: How do you do this outside a stored procedure? 
-- If you cannot write it as regular T-SQL you’ll never be able to write the procedure. 
-- How do you toggle without an if? Easy subtract 1 from the current value!

-- toggle it
update fudgemart_products set product_is_active = 1 - product_is_active where product_id = 1
-- view the results
select * from fudgemart_products where product_id=1

--NOW WE CAN WRITE THE PROCEDURE:
if exists(select * from sys.objects where name = 'p_toggle_product_activation')
drop procedure p_toggle_product_activation
go

create procedure p_toggle_product_activation(
@product_id int
) as
begin
	declare @current_status as bit
	update fudgemart_products set product_is_active = 1 - product_is_active 
		where product_id = @product_id
	set @current_status = (select product_is_active from fudgemart_products 
		where product_id=@product_id)
	return @current_status
end
go
