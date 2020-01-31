USE [demo]
GO

DROP TABLE [dbo].[accounts]
GO 

CREATE TABLE [dbo].[accounts](
	[account] [varchar](50) NOT NULL,
	[balance] [money] NOT NULL,
	CONSTRAINT [CK_account_balance_not_less_than_zero]  CHECK ([balance] >=0),
	CONSTRAINT [PK_accounts] PRIMARY KEY  ([account])
)
GO

insert into accounts values ('checking', 500)
insert into accounts values ('savings', 1000)
