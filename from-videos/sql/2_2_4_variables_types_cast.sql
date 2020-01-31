declare @salary money
set @salary = 75000
print 'John makes $' + cast(@salary as varchar) + ' per year.'

-- does not work
print 'John makes $' + @salary + 'per year'