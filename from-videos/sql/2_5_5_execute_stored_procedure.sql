-- GOOD
exec p_toggle_product_activation 1 
go


-- BETTER, stores the result
declare @result bit
exec @result =p_toggle_product_activation 1 
print @result
go
select * from fudgemart_products where product_id=1

-- BEST – Stores the result and uses a Named argument. Intent is clear!
declare @result bit
exec @result =p_toggle_product_activation @product_id=1 
print @result
select * from fudgemart_products where product_id=1
