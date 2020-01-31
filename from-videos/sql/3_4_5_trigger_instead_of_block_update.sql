-- prevent update example
use demo
go

select * from accounts 

-- add a column called locked. You are not allowed to withrawl or deposit a locked account
alter table accounts add
	locked bit default(0) not null -- not null sets the default
go
update accounts set locked =1 where account = 'money-market'
select * from accounts 

-- make the tridder
if exists(select * from sys.objects where name = 't_accounts_block_locked')
drop trigger t_accounts_block_locked
go
create trigger t_accounts_block_locked
	on accounts
	instead of update as
begin
	if exists(select * from inserted where locked=1) 
	begin
		; --huh? This is required because you cannot say begin... throw
		THROW 50005, 'No changes permitted, one of the rows used a locked account',1
		rollback
	end 
	else -- perform the update as usual.
	begin
		update accounts set accounts.balance= inserted.balance
		from inserted
		where accounts.account = inserted.account
	end
end
go

--- no changes permitted, account locked
update accounts set balance = balance +1000000 where account = 'money-market'
-- no changes
select * from accounts 

-- this transfer works, notice how the other trigger still fires!
exec dbo.p_transfer_money 'checking','savings', 100
select * from accounts 

-- this transfer will not work.
exec dbo.p_transfer_money 'money-market','savings', 500





