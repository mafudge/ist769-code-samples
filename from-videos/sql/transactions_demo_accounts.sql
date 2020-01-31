select * from accounts 

BEGIN TRY
	BEGIN TRANSACTION 
	-- manipulate data here
	UPDATE accounts set balance = balance - 500 where account = 'savings'
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