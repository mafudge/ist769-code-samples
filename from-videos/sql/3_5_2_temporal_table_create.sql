  
use demo
go

-- need to drop this - instead of triggers not compatible with temporal tables. 
-- we could re-write this as a after trigger....
drop trigger t_accounts_block_locked
go

update accounts set balance = 1000

select * from accounts 

/*   
Turn ON system versioning in Employee table in two steps   
(1) add new period columns (HIDDEN)   
(2) create default history table   
*/ 
ALTER TABLE accounts   
ADD   
    valid_from datetime2 (2) GENERATED ALWAYS AS ROW START HIDDEN    
        constraint df_valid_from DEFAULT DATEADD(second, -1, SYSUTCDATETIME())  
    , valid_to datetime2 (2)  GENERATED ALWAYS AS ROW END HIDDEN     
        constraint df_valid_to DEFAULT '9999.12.31 23:59:59.99'  
    , PERIOD FOR SYSTEM_TIME (valid_from, valid_to);   
go

ALTER TABLE accounts   
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.accounts_history)); 
go

select  * from accounts
select * from accounts_history

-- execute some transfers, pause a few seconds between each
exec dbo.p_transfer_money 'checking','savings', 100
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'checking','savings', 100
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'savings','checking', 200
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'checking','savings', 300
WAITFOR DELAY '00:00:05'
update accounts set locked = 0 where account = 'money-market'
exec dbo.p_transfer_money 'money-market','checking', 1000
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'money-market','savings', 1500
WAITFOR DELAY '00:00:05'


select  * from accounts
select * from accounts_history



