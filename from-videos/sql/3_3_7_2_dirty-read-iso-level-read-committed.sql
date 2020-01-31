use demo

set transaction isolation level read committed 
go

-- we can read checking... that write is not locked
select * from accounts where account ='checking'

print @@lock_timeout 

-- this query will be blocked as we have a lock in place from the update.
select * from accounts 