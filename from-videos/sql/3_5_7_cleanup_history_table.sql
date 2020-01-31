--- this does not work not allows to do this with SYSTEM_VERSIONING = ON

delete from dbo.accounts_history
go

ALTER TABLE dbo.accounts
SET (SYSTEM_VERSIONING = OFF);
GO
 
---Delete unnecessary data from the history table:

 
DELETE FROM dbo.accounts_history
WHERE valid_to <= '2018-10-2 20:00:29';
 
-- and then re-enable system versioning:

 ALTER TABLE dbo.accounts
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.accounts_history));
 