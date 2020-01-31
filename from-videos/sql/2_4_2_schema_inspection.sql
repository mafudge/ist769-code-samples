-- Look at the System views 
use fudgemart_v3
go

-- ANSI Standard
--tables in fudgemart
select * from INFORMATION_SCHEMA.TABLES

-- columns in fudgemart_customers
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='fudgemart_customers'

-- primary and foreign key constraibts in fudgemart_order_details
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
where TABLE_NAME='fudgemart_order_details'

-- SQL Server specific -a lot more lower level

-- all objects in the database
select * from sys.objects where name like 'fudgemart%'

select * from sys.tables 

select * from sys.columns where name like 'customer%'
