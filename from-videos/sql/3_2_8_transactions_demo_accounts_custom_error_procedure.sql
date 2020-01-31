-- reset the accounts table
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

-- wrapping the code in a procedure makes it easier to enapsulate the data logic.
go
if exists(select * from sys.objects where name='p_transfer_money')
	DROP PROCEDURE p_transfer_money
GO
CREATE PROCEDURE p_transfer_money (
	@from varchar(50),
	@to varchar(50),
	@amount money
) AS
BEGIN TRY
	BEGIN TRANSACTION 
	-- manipulate data here
	UPDATE accounts set balance = balance - @amount where account = @from
	if @@ROWCOUNT <> 1 THROW 50001, 'update to accounts table effected 0 rows, expecting 1',0
	UPDATE accounts set balance = balance + @amount where account = @to
	if @@ROWCOUNT <> 1 THROW 50001, 'update to accounts table effected 0 rows, expecting 1',0
	PRINT 'Committing'
	COMMIT --save
END TRY
BEGIN CATCH
	SELECT error_number() as error, error_message() as message
	PRINT 'Rolling back'
	ROLLBACK --undo
END CATCH
go


SELECT * from accounts 

EXEC p_transfer_money @from='checking', @to='savings', @amount=100  -- change to 'savingz' still works!

SELECT * from accounts



/*
BEGIN TRY
	BEGIN TRANSACTION 
	-- manipulate data here

	COMMIT --save
END TRY
BEGIN CATCH
	PRINT error_message()
	ROLLBACK --undo
END CATCH
*/