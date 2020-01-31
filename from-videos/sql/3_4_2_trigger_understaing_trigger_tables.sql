-- reset the balances
update accounts set balance = 1000
go
select * from accounts
go

if exists (select * from sys.objects where name = 't_accounts_trigger_demo')
drop trigger t_accounts_trigger_demo
go
create trigger t_accounts_trigger_demo
	on accounts
	after insert, update, delete as
begin
	select 'inserted table:',* from inserted -- how the data "is"
	select 'deleted table:', * from deleted  -- how the data "was"
end
go

-- lets deposit $500 to all accounts and watch what the trigger does
update accounts set balance = balance + 500

-- let's execute our stored procedure. Trigger fires twice - two statements!
exec p_transfer_money @from='savings', @to='checking', @amount=250