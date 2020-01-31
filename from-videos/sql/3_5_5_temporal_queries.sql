select  * from accounts
select * from accounts_history

-- what it looks like now
select * from accounts 

-- NOTE: these will need to be changed to reflect your times
--what the 3 rows look like at a point in time
select * from accounts for system_time AS OF '2018-10-02 21:16'
select * from accounts for system_time AS OF  '2018-10-02 21:20'

-- full history of changes to savings account over time -timeseries
select * from accounts for system_time all 
	where account = 'savings'
	order by updated_on desc

-- let's get changes in a range
select * from accounts for system_time between '2018-10-02 21:15' and '2018-10-02 21:20'

select * from accounts for system_time between '2018-10-02 21:20' and '2018-10-02 22:00'

-- 