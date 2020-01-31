alter table accounts add
	updated_by varchar(50),
	updated_on datetime2
go

select * from accounts

-- reset checking and savings to 1000
update accounts set balance = 1000 where account in ('checking', 'savings')
-- add a new account 
insert into accounts (account,balance) values ('money-market', 10000)

select * from accounts 
go

select current_user as updated_by, getdate() as updated_on
go

if exists (select * from sys.objects where name = 't_accounts_timestamp_afer_update')
drop trigger t_accounts_timestamp_afer_update
go
create trigger t_accounts_timestamp_afer_update
	on accounts
	after update as
begin
	update accounts set updated_by =current_user, updated_on =getdate()
		from inserted  								-- table with affected changes
		where accounts.account = inserted.account 	-- this is common trigger logic!
end
go


-- deposit $50 into all accounts, one trigger
update accounts set balance = balance + 500 where account = 'money-market'
select * from accounts 

-- transfer money two separate triggers here.
exec dbo.p_transfer_money 'checking','savings', 100
select * from accounts 
