begin try
	select 1/0
end try
begin catch
	print error_message()
end catch




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