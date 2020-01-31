-- open this script as the testuser account

-- 2
select * from INFORMATION_SCHEMA.TABLES

-- 4 still cant see it ! :-(
select * from INFORMATION_SCHEMA.TABLES

-- 5 try to insert... nope
insert into accounts (account, balance) values( 'ira',0)

-- 7 execute the procedure
execute dbo.p_transfer_money @from='savings', @to='checking', @amount=1
select * from accounts 

-- 8 no longer read table
select * from accounts

--but you can read the view!
select * from v_accounts