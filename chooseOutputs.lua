local A 	= 170;
local B 	= 171;
local LEFT 	= 172;
local RIGHT	= 173;

local AIR = 0
local TILE = 1
local GOOMBA = 2

nodes = {};
connections = {};

require('NEAT/util/generateNeurons')
require('NEAT/models/Node')
require('NEAT/models/connection')


--Solve the node recursively
function solveNode(node)
	for k, conn in pairs(node.connections) do
		--Recursively solve the node
		if (conn.to.litTile and conn.litTile) then return end;
		if (conn.to.litGoomba and conn.litGoomba) then return end;
		--Only try to light the node if it's not lit already
		if (conn.type == 1 and node.litTile) then conn.to.litTile = true end;
		if (conn.type == 2 and node.litGoomba) then conn.to.litGoomba = true end;
		return solveNode(conn.to);
	end

end

--Select which buttons to press based off the synapses
function chooseOutputs(synapses, tiles)
	
	local neurons = generateNeurons(synapses);

	--Create a Node for every Neuron and add it to the nodes
	for k, neur in pairs(neurons) do
		local node = Node:new();
		node.ID = neur.label;
		node.type = neur.type;
		nodes[node.ID] = node;

	end;

	--Iterate through all the synapses in the species
	for k, syn in pairs(synapses) do
		local connection = Connection:new();
		connection.id = syn.historicalMarking;
		connection.to = nodes[syn.to];
		connection.from = nodes[syn.from];
		connection.weight = syn.weight;
		table.insert(nodes[syn.from].connections, connection);
	end;

	--Check the power of the first layer of Nodes

	for idx=1,168 do
		--Ensure we have a node associated with that tile
		if (nodes[idx]) then
			local node = nodes[idx];
			--Find the coordinates of the tile
			local y = math.floor(idx / 13) - 6;
			local x = (idx % 13);
			if x == 0 then x = 13 end;
			--Find the value at the tile
			local tileVal = tiles[y][x];
			--Node is lit of tileVal == node.type

			--Light the respective connections
			litGoomba = tileVal == 2;
			litTile = tileVal == 1;

			node.litGoomba = litGoomba;
			node.litTile = litTile;

			for k,conn in pairs(node.connections) do
				if (conn.type == 1 and litTile) then conn.litTile = true end;
				if (conn.type == 2 and litGoomba) then conn.litGoomba = true end;
			end
			--Solve the node
			solveNode(node);

		end;
	end

	local nodeA 	= nodes[A];
	local nodeB 	= nodes[B];
	local nodeRight = nodes[RIGHT];
	local nodeLeft 	= nodes[LEFT];


	local outputs = {};


	outputs.a 		= nodeA.litTile or nodeA.litGoomba;
	outputs.b 		= nodeB.litTile or nodeB.litGoomba;
	outputs.right 	= nodeRight.litTile or nodeRight.litGoomba;
	outputs.left 	= nodeLeft.litTile or nodeLeft.litGoomba;
	return outputs;
	-- print(pretty(nodes));
	--Check if we've created a Node from the IDs yet
end