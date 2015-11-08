Synapse = {}

currentSynapse = 0

local AIR = 0
local TILE = 1
local GOOMBA = 2

function Synapse:new()
	currentSynapse = currentSynapse + 1

	local synapse = {}

	-- ID of the synapse
	synapse.historicalMarking = currentSynapse

	-- Set to IDs of Neurons
	synapse.from = 0
	synapse.to = 0

	-- Weight of the connection
	synapse.weight = 0.0

	-- Whether the synapse is being expressed or not
	synapse.enabled = true

	synapse.type = TILE;

	synapse.lit = false;
	return synapse
end

function Synapse:copy(oldSynapse)
	local newSynapse = Synapse:new()

	newSynapse.historicalMarking = oldSynapse.historicalMarking
	newSynapse.from = oldSynapse.from
	newSynapse.to = oldSynapse.to
	newSynapse.weight = oldSynapse.weight
	newSynapse.enabled = oldSynapse.enabled

	return newSynapse
end