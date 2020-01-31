use demo

set transaction isolation level read uncommitted 
go

-- this will read dirty data 9999 - the uncommitted tranaction.

select * from accounts 

