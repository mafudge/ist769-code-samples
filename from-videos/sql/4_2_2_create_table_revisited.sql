
-- GENERATED SCRIPT FROM GUI - show gui

GO
ALTER DATABASE [demo] ADD FILEGROUP [TESTING]
GO
ALTER DATABASE [demo] ADD FILE ( 
    NAME = N'testing', 
    FILENAME = N'/var/opt/mssql/data/testing.ndf' , 
    SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [TESTING]
GO


-- create a table with PK in different filegroup
CREATE TABLE [dbo].[accounts2](
[account] [varchar](50) NOT NULL,
[balance] [money] NOT NULL,
 CONSTRAINT [PK_accounts2] PRIMARY KEY NONCLUSTERED ([account] ASC) ON [TESTING] -- specify filegroup
 ) ON [PRIMARY] -- table filegroup
