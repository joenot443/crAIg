local S = {};

marioX = 0;
marioY = 0;

--Read and return the enemy sprites' coords
local function readEnemySprites()
	sprites = {};
	for slot = 0,4 do
		local enemy = memory.readbyte(0xF+slot);
		if enemy ~= 0 then
			local ex = memory.readbyte(0x6E + slot)*0x100 + memory.readbyte(0x87+slot);
			local ey = memory.readbyte(0xCF + slot)+24;
			sprites[#sprites+1] = {["x"]=ex, ["y"]=ey};
			end
		end
	return sprites;
	end

--Read and return Mario's coords
local function readMario()
	local mario = {};
	marioX = memory.readbyte(0x6D) * 0x100 + memory.readbyte(0x86);
	marioY = memory.readbyte(0x03B8)+16;
	mario['marioX'] = marioX;
	mario['marioY'] = marioY;
	return mario;
end

local function readScreen()
	local screen = {};
	screen['screenX'] = memory.readbyte(0x071D);
	screen['screenY'] = memory.readbyte(0x03B8);
	return screen;
end

--Read and return the tile types and coords
local function readTiles()

	--Radius of our box around mario
	local radius = 6;
	local tiles = {};

	--Iterate through all tiles and find their types
	for dy = -radius*16, radius*16, 16 do
		--Create a new row for each iteration
		tiles[dy/16] = {}
		
		for dx = -radius*16, radius*16, 16 do
			--Create a new tile for each iteration
			tiles[dy/16][#tiles[dy/16]+1] = 0;

			--Decide whether to skip this block
			skip = false;

			local spriteX = marioX + dx + 8;
			local spriteY = marioY + dy - 16;

			local page = math.floor(spriteX/256)%2;

			local subSpriteX = math.floor((spriteX%256)/16)
			local subSpriteY = math.floor((spriteY - 32)/16)
			local address = 0x500 + page*13*16+subSpriteY*16+subSpriteX

			--Sprite is outside our range of drawing
			if subSpriteY < 0 then
				skip = true;
			end

			--Check the value of the sprite block
			local tileVal = memory.readbyte(address)

			if tileVal ~= 0 and marioY+dy < 0x1B0 and not skip then
				tiles[dy/16][#tiles[dy/16]] = 1;
			end
		end
	end


	--Check if there's an enemy in the block
	for i = 1, #sprites do

		local enX = sprites[i]["x"];
		local enY = sprites[i]["y"];



		local enDX = - (marioX - enX) / 16;
		local enDY = - (marioY - enY) / 16;

		local enRelTileX = math.floor(enDX);
		local enRelTileY = math.floor(enDY);

		if math.abs(enRelTileX) <= 6 and enRelTileY <= 8 then

			if (enRelTileY > 6) then enRelTileY = 6 - enRelTileY end;
			--Ensure we're drawing in the bounds of our coords

			if -6 < enRelTileY and enRelTileY < 6 and 0 < (enRelTileX + 8) and (enRelTileX + 8) < 14 then
				tiles[enRelTileY][enRelTileX + 8] = 2
			end
		end
	end

	tiles[1][7] = 3;
	return tiles;
end






S.readEnemySprites = readEnemySprites;
S.readScreen = readScreen;
S.readMario = readMario;
S.readTiles = readTiles;

return S


