-- use the gui to get 
-- Database: Reports: index usage statistics
-- Database: Reports: index physical statistics 

USE [fudgemart_v3]
GO
ALTER INDEX [ix_fudgemart_customers] ON [dbo].[fudgemart_employees] REBUILD 
