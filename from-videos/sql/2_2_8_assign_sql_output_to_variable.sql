use fudgemart_v3
go
-- look at fudgemart_vendors
select * from fudgemart_vendors

-- count vendors who don't have a website
select count(*) from fudgemart_vendors 
	where vendor_website is not NULL

-- put it all together, saving this information into a varable when the scrip runs.

declare @website_count int
set @website_count = (select count(*) 
	from fudgemart_vendors 
	where vendor_website is not null
)
print 'There are ' + cast(@website_count as varchar) + ' vendor websites.'

-- another example:
declare @customer_count int
set @customer_count = (select count(*) from fudgemart_customers)
print 'there are ' + cast(@customer_count as varchar) + ' customers in fudgemart'