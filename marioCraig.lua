emu.speedmode("normal");

local MarioXAddress = 0x0086;
local Enemy1XAddress = 0x0087;
local Enemy2XAddress = 0x0088;
local MarioX;
local Enemy1X;
local Enemy2X;

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

--Require files
--local FileOut = require('FileOut');
local ReadMemory = require('ReadMemory');
local JSON = require('JSON');

--Game framt count
local ticker = 0;




-- Game loop
while (true) do
	ticker = ticker + 1;

	--Every 120 frames we'll output a new file
	if (ticker == 30) then
		print("writing file");

		local enemySprites = ReadMemory.readEnemySprites();
		local screen = ReadMemory.readScreen();
		local mario = ReadMemory.readMario();
		local tiles = ReadMemory.readTiles();

		local data = {};
		
		data["tiles"] = tiles;

		local file = io.open('output.json', 'w+');
		io.output(file);
		io.write(JSON:encode_pretty(data));
		io.close();
		ticker = 0;
	end

	emu.frameadvance();
end;