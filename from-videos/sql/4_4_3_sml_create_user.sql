use master
go

create login testuser with password=N'testing123!'
	,DEFAULT_DATABASE=demo
	,CHECK_EXPIRATION=OFF 
	,CHECK_POLICY=OFF
go

use demo
go
create user testuser from login testuser
go 


select * from  sys.database_principals
select * from sys.database_permissions

