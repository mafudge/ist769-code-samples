if exists( select * from fudgemart_customers where customer_id=1)
	print 'Customer ID 1 exists'
else
	print 'Customer ID 1 is not a valid customer!'

