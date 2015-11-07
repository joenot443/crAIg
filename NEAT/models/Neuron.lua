Neuron = {}

currentNeuron = 0

local AIR = 0
local TILE = 1
local GOOMBA = 2

function Neuron:new()
	currentNeuron = currentNeuron + 1

	local neuron = {}
	
	-- ID of the neuron
	neuron.label = currentNeuron
	
	-- Type of the neuron (which set of inputs its connected to)
	neuron.type = AIR

	return neuron
end
