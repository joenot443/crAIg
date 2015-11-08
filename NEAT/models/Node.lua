local AIR = 0
local TILE = 1
local GOOMBA = 2

Node = {};

function Node:new() 

	local node = {};
	--ID of the Node
	node.ID = 0;
	--Connections to other Nodes
	node.connections = {};
	--Type of the Node
	node.type = 0;
	--Whether Node is lit
	node.litGoomba = false;
	node.litTile = false;

	return node;
end;