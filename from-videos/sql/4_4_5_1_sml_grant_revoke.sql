-- open this script as the sa account 

select * from  sys.database_principals
select * from sys.database_permissions

-- 1
grant select on schema::dbo to testuser
GO

--3 now lets make another schema
create schema nopermissions
go
create table nopermissions.test (id int)
go

--6 grant execute rights to the sp
grant execute on object::p_transfer_money to testuser 
go
select name, principal_id, p.* from sys.database_permissions p
	join sys.database_principals on principal_id=grantee_principal_id
	where name = 'testuser'

-- 8
go
create view v_accounts as
	select account, balance from accounts where locked = 0
go
grant select on object::v_accounts to testuser
go
deny select on object::accounts to testuser
go