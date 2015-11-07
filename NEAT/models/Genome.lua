require("NEAT/config")
require("NEAT/models/Synapse")

Genome = {}

function Genome:new()
	local genome = {}

	-- Fill with Synapse objects
	-- We can build a network using only synapse objects by adding neurons when they are referenced.
	-- First synapses are as follows:
		-- Input neurons (169), Output neurons (4), hidden neurons
	genome.synapses = {}

	--This represents the label of the newest Neuron in this Genome.
	--We keep track of this so that we can easily add synapses
	genome.maxNeuron = INPUT_COUNT + OUTPUT_COUNT

	--Calculated using fitness function
	genome.fitness = 0

	return genome
end

function Genome:copy(oldGenome)
	local newGenome = Genome:new()

	--Copy the synapses over
	for s=1,#oldGenome.synapses do
		table.insert(newGenome.synapses, Synapse:copy(oldGenome.synapses[s]))
	end

	--Copy the max neuron over
	newGenome.maxNeuron = oldGenome.maxNeuron

	return newGenome
end