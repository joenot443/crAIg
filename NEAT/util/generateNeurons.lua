package.path = package.path .. ";../?.lua"
require("config")
require("models/Neuron")
require("models/Synapse")

-- Generate neurons given synapses
function generateNeurons(synapses)
	local neurons = {}
	currentNeuron = 0

	-- Inputs
	for i=1,INPUT_COUNT do
		local inputNeuron = Neuron:new()
		table.insert(neurons,inputNeuron)
	end

	--Outputs
	for i=1,OUTPUT_COUNT do
		local outputNeuron = Neuron:new()
		table.insert(neurons,outputNeuron)
	end

	--Hidden Neurons
	for i=1,#synapses do
		local synapse = synapses[i]
		--If they reference neurons that don't already exist
		if (synapse.from > (INPUT_COUNT + OUTPUT_COUNT)) or (synapse.to > (INPUT_COUNT + OUTPUT_COUNT)) then
			local hiddenNeuron = Neuron:new()
			table.insert(neurons,hiddenNeuron)
		end
	end

	return neurons
end