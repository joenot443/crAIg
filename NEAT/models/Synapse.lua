Synapse = {}

currentSynapse = 0

function Synapse:new()
	currentSynapse++

	local synapse = {}

	-- ID of the synapse
	synapse.label = currentSynapse

	-- Set to IDs of Neurons
	synapse.from = 0
	synapse.to = 0

	-- Weight of the connection
	synapse.weight = 0.0

	-- Whether the synapse is being expressed or not
	synapse.enabled = true

	return synapse
end