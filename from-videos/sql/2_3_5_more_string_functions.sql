use fudgemart_v3
go

-- highlight any function and press F1 to see the books online.
-- replacing nulls with isnull value **No Website** instead of null
SELECT vendor_name, vendor_website, 
	isnull(vendor_website, '**No Website**') as vendor_website2
  FROM fudgemart_vendors

-- example of how to use string split
declare @fruits as varchar(max)
set @fruits = 'apple,orange,cherry,blueberry'
select value as fruit from string_split(@fruits,',')

-- example of how to use string agg
select customer_state, customer_email from fudgemart_customers

select customer_state, string_agg(customer_email, ', ') 
from fudgemart_customers
group by customer_state
 
