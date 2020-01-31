-- What is the highest priced product? What is its price?
select top 1 product_name, product_retail_price 
    from fudgemart_products
    order by product_retail_price desc


-- assign SQL row output to variables
declare @product_name as varchar(max)
declare @retail_price as money 

select top 1  
	@product_name = product_name,  
	@retail_price = product_retail_price 
	from fudgemart_products 
	order by product_retail_price desc

print 'Highest Priced product is ' + @product_name
print 'Retail price is $' + cast (@retail_price as varchar(max))