-- sql programming examples
print 'hello, world'

-- variables and assignment with declare and set
declare @1 int --anything with an @ in front
set @1 = 99
print 'the value is'
print @1

-- assign a variable to a scalar table output
declare @customer_count int
set @customer_count = (select count(*) from fudgemart_customers)
print 'there are ' + cast(@customer_count as varchar) + ' customers in fudgemart'

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

--cast and convert
print cast( '10' as int) -- ANSI SQL standard
print convert(int,'10') -- SQL Server specfic

--information schema
select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='fudgemart_customers'
select * from INFORMATION_SCHEMA.CHECK_CONSTRAINTS
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS

-- exists
if exists(select * from sys.objects where name = 'fudgemart_customers')
begin
	select * from fudgemart_customers
end
else
begin
	print 'No table called fudgemart_customers'
end

-- create table if not exists
use demo
go
if not exists(select * from sys.objects where name = 'test_table')
begin
	create table test_table (
		id int identity not null,
		val varchar(100) not null
		constraint pk_test_table_id primary key (id)
	)
	insert into test_table values ('a')
	insert into test_table values ('b')
	insert into test_table values ('c')
end 
else
begin
	select * from test_table
	drop table test_table
end

