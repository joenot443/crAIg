local joyRight 	= {right=true};
local joyLeft 	= {left=true};
local joyUp 	= {up=true};
local joyDown 	= {down=true};
local joyA 		= {a=true};
local joyB		= {b=true};



local function pressRight()
	joypad.set(1, joyRight);
end;
local function pressLeft()
	joypad.set(1, joyLeft);
end;
local function pressUp()
	joypad.set(1, joyUp);
end;
local function pressDown()
	joypad.set(1, joyDown);
end;
local function pressA()
	joypad.set(1, joyA);
end;
local function pressB()
	joypad.set(1, joyB);
end;