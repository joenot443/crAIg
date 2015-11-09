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
local ReadMemory = require('runtime/ReadMemory');
local JSON = require('runtime/json');
require("NEAT/config");

--Game frame count
local ticker = 0;
firstRun = true;
local aPressedTicker = 0;

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
		local file = io.open('runtime/live/graph.json', 'w+');
		io.output(file);
		io.write(JSON:encode_pretty(data));
		io.close();
		
		if (firstRun) then 
			local file = io.open('runtime/live/network.json', 'w+');
			io.output(file);
			data =  {}
			data['synapses'] = synapses;
			data['genome'] = genome.id;
			io.write(JSON:encode_pretty(data));
			io.close();
			firstRun = false;
		end
		local file = io.open('runtime/live/litmap.json', 'w+');
		io.output(file);
		local connectionsLitArr = {};
		for k,v in pairs(connectionsLitMap) do
			table.insert(connectionsLitArr, v);
		end

		io.write(JSON:encode_pretty(connectionsLitArr));
		io.close();
		ticker = 0;
	end

	local realOut = {}
	--Press joy buttons
	if MODDED_ALGORITHM then
		if outputs.a  and aPressedTicker < 10 then 
			realOut.A = true
			aPressedTicker = aPressedTicker + 1;
		 else realOut.A = false 
		 	aPressedTicker = 0;
		 	end;
	else
		if outputs.a then realOut.A = true else realOut.A = false end;
	end
	if outputs.b then realOut.B = true else realOut.B = false end;	
	if outputs.left then realOut.left = true else realOut.left = false end;	
	if outputs.right then realOut.right = true else realOut.right = false end;

	joypad.set(1,realOut)

	emu.frameadvance();

	return tiles;
end;