-- temporal table example 

alter table foo set (SYSTEM_VERSIONING = OFF)
drop table if exists foo_history 
drop table if exists foo
GO 

create table foo_history
(
	foo_id int not null,
	foo_name varchar(50) not null,
	SysStartTime datetime2 NOT NULL,
    SysEndTime datetime2 NOT NULL
)
GO 
CREATE CLUSTERED COLUMNSTORE INDEX ix_foo_history
   ON foo_history;
CREATE NONCLUSTERED INDEX ix_foo_history_period_columns  
   ON foo_history (SysEndTime, SysStartTime, foo_id);   
GO 

create table foo
(
	foo_id int identity not null,
	foo_name varchar(50) not null,
	SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
    SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,  
    PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime),  
   	constraint pk_foo primary key (foo_id)
) with (SYSTEM_VERSIONING = ON (HISTORY_TABLE =dbo.foo_history) )
GO

--alter table foo set (SYSTEM_VERSIONING = OFF);