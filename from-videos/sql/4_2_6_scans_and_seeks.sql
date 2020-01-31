use fudgemart_v3
-- table scan because there is no key on the table.
select * into emp_test from fudgemart_employees 
select * from emp_test 

-- clustered index scans
select employee_firstname, employee_lastname  from fudgemart_employees
select employee_firstname, employee_lastname employee_department 
	from fudgemart_employees where employee_department = 'Electronics'

-- clustered index seeks, PK in the where clause
select employee_firstname, employee_lastname  from fudgemart_employees 
	where employee_id = 5
select employee_firstname, employee_lastname  from fudgemart_employees 
	where employee_id in (5,10,15,20)

-- make an index
drop index ix_fudgemart_customers on fudgemart_employees
go
create index ix_fudgemart_customers on fudgemart_employees (employee_department) 
	include (employee_firstname, employee_lastname)
go

-- still a scan, why? cloumns are not covered!
select * from fudgemart_employees 
	where employee_department = 'Hardware'

-- now we get an index seek! Very efficient!
select employee_firstname, employee_lastname	
	from fudgemart_employees 
		where employee_department='Electronics'

-- when we include all rows we get an index scan. Better to scan the index than the table!
select employee_firstname, employee_lastname	
	from fudgemart_employees 
	order by employee_department
