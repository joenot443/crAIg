local idx = 25;

local y = math.floor(idx / 13) - 6;
local x = (idx % 13);
if x == 0 then x = 13 end;
if y == 7 then y = 6 end;

print(y);
print(x);