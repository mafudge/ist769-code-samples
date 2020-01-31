if exists(select * from sys.objects where name = 'v_products_with_vendors')
	drop view v_products_with_vendors
go

create view v_products_with_vendors
as
	select p.product_id, p.product_name, p.product_retail_price, v.*
		from fudgemart_products p join fudgemart_vendors v on p.product_vendor_id= v.vendor_id
go


-- does not work because it's not schema bound
create unique clustered index ix_v_products_with_vendors 
	on v_products_with_vendors(product_id, vendor_id)
go

-- the view is there, but the exection plan uses an index scan and seek with a join ... 
-- we want this simplified for performance 
select * from  v_products_with_vendors

-- solution

if exists(select * from sys.objects where name = 'v_products_with_vendors')
	drop view v_products_with_vendors
go

create view v_products_with_vendors
with schemabinding
as
	select p.product_id, p.product_name, p.product_retail_price, v.vendor_id, v.vendor_name, v.vendor_phone, v.vendor_website
		from dbo.fudgemart_products p join dbo.fudgemart_vendors v on p.product_vendor_id= v.vendor_id
go

-- now we can index!
create unique clustered index ix_v_products_with_vendors on v_products_with_vendors(product_id, vendor_id)
go

-- much simpler execution plan because the view has been materliazed
select * from  v_products_with_vendors