Use DEMO
GO

--FIRST demonstrate TRY CATCH
BEGIN TRY
    BEGIN TRANSACTION 
    -- manipulate data here
    SELECT 1/0   -- make divide by zero to show CATCH
    PRINT 'Committing'
    COMMIT --save
END TRY
BEGIN CATCH
    SELECT error_message()
    PRINT 'Rolling back'
    ROLLBACK --undo
END CATCH


-- Create the ACCOUNTS table to be used in the demos.

USE [demo]
GO

if exists(select * from sys.objects where name='accounts')
    DROP TABLE [dbo].[accounts]
GO 

CREATE TABLE [dbo].[accounts](
[account] [varchar](50) NOT NULL,
[balance] [money] NOT NULL,
CONSTRAINT [CK_account_balance_not_less_than_zero]  CHECK ([balance] >=0),
CONSTRAINT [PK_accounts] PRIMARY KEY  ([account])
)
GO

-- Starting balances
insert into accounts values ('checking', 500)
insert into accounts values ('savings', 1000)

select * from accounts 

--WORKING TRANSACTION  move $500 from savings into checking

BEGIN TRY
BEGIN TRANSACTION 
-- manipulate data here
    UPDATE accounts set balance = balance - 500 where account = 'savings' -- change to 'savingz'
    UPDATE accounts set balance = balance + 500 where account = 'checking'
    PRINT 'Committing'
    COMMIT --save
END TRY
BEGIN CATCH
    SELECT error_number() as error, error_message() as message
    PRINT 'Rolling back'
    ROLLBACK --undo
END CATCH

SELECT * from accounts

-- run the transaction a few times to see it not commit

