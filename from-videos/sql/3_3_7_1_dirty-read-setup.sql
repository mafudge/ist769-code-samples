

-- setup 
use demo

BEGIN TRAN -- open a transaction

UPDATE accounts set balance = 9999 where account='savings'

PRINT @@TRANCOUNT 

--ROLLBACK