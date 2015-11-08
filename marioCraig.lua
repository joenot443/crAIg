emu.speedmode("normal");

--Constants
local MARIOX_ADDR = 0x0086;
local LOG_OUTPUT = true;

--Joypad buttons

local joyRight 	= {right=true};
local joyLeft 	= {left=true};
local joyUp 	= {up=true};
local joyDown 	= {down=true};
local joyA 		= {A=true};
local joyB		= {B=true};

--Require files
--local FileOut = require('FileOut');
local ReadMemory = require('ReadMemory');
local JSON = require('json');

--Game frame count
local ticker = 0;
firstRun = true;

--Save and persist our initial state
local originalState = savestate.create();
savestate.save(originalState);
savestate.persist(originalState);

--Returns the initial boardstate
function initialState() 
	--First load the save state
	savestate.load(originalState);

	emu.frameadvance();
	local tiles = readScreen();
	return tiles;
end

function readScreen() 
	local enemySprites = ReadMemory.readEnemySprites();
	local screen = ReadMemory.readScreen();
	local mario = ReadMemory.readMario();
	local tiles = ReadMemory.readTiles();

	return tiles;
end

function runFrame(outputs, genome) 


	ticker = ticker + 1;

	--Every 30 frames we'll output a new file
	local enemySprites = ReadMemory.readEnemySprites();
	local screen = ReadMemory.readScreen();
	local mario = ReadMemory.readMario();
	local tiles = ReadMemory.readTiles();

	local data = {};
	data.tiles = tiles;
	
	if (ticker == 30) then
		local file = io.open('graph.json', 'w+');
		io.output(file);
		io.write(JSON:encode_pretty(data));
		io.close();
		
		if (firstRun) then 
			local file = io.open('network.json', 'w+');
			io.output(file);
			data =  {}
			data['synapses'] = synapses;
			data['genome'] = genome.id;
			io.write(JSON:encode_pretty(data));
			io.close();
			firstRun = false;
		end
		local file = io.open('litmap.json', 'w+');
		io.output(file);
		local connectionsLitArr = {};
		for k,v in pairs(connectionsLitMap) do
			table.insert(connectionsLitArr, v);
		end

		io.write(JSON:encode_pretty(connectionsLitArr));
		io.close();
		ticker = 0;
	end

	--Press joy buttons
	if outputs.a then joypad.set(1, joyA); end;
	if outputs.b then joypad.set(1, joyB) end;	
	if outputs.left then joypad.set(1, joyLeft) end;	
	if outputs.right then joypad.set(1, joyRight) end;

	emu.frameadvance();

	return tiles;
end;