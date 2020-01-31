--json queries

-- CONVERTING JSON into TABLES:
-- one row for each product
select * from products

-- OPENJSON flattens each JSON Review into its own row.  2 handlebars
-- NOTE: cross apply applies the OPENJSON function to each row in the products table
select * from products cross apply OPENJSON(reviews)

-- are you sad we lost our seat row? try:
select * from products outer apply OPENJSON(reviews)


-- let's extract the fields. $.Reviewer.Name is a JSON Path shows us how to get to a value
-- with improves performance
select id, name,price, reviewer_name, rating from products 
	cross apply OPENJSON(Reviews) WITH ( reviewer_name  varchar(50) '$.Reviewer.Name', rating int '$.Reviewer.Rating')

-- how about all the fields?
select id, name,price, reviewer_name ,email, rating from products 
	cross apply OPENJSON(Reviews) 
		WITH ( reviewer_name  varchar(50) '$.Reviewer.Name', email varchar(20) '$.Reviewer.Email', rating int '$.Reviewer.Rating')

-- CONVERTING TABLES INTO JSON
select account, balance from accounts for json auto 

-- double escaped! Yuck!
select * from products for json auto 

-- use JSON_QUERY() to get pure JSON!
select id, name,price, JSON_QUERY(reviews) as Reviews from products for json auto 

-- The coup de grace! average reviews as back as a JSON!
select id, name, avg(rating) as avg_rating 
	from products 
		cross apply OPENJSON(Reviews) WITH ( rating decimal(4,1) '$.Reviewer.Rating')
	group by id, name
	for json auto


