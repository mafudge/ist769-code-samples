declare @msg nvarchar(20)
set @msg = 'hello, world'

print len(@msg)  -- 12
print left(@msg, 4) -- 'hell'
print right(@msg, 4) -- 'orld'
print charindex(',', @msg) -- 6
print left(@msg, charindex(',', @msg)-1) --hello

declare @s nvarchar(20)
set @s = 'syracuse,ny'
print right(@s, len(@s) - charindex(',',@s))
