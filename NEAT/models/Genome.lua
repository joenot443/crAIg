Genome = {}

function Genome:new()
	local genome = {}

	-- Fill with Synapse objects
	-- We can build a network using only synapse objects by adding neurons when they are referenced.
	genome.synapses = {}

	--This represents the label of the largest Neuron in this Genome.
	--We keep track of this so that we can easily add synapses
	genome.maxNeuron = 0

	--Calculated using fitness function
	genome.fitness = 0

	return genome
end

function Genome:copy(oldGenome)
	local newGenome = Genome:new()

	--Copy the synapses over
	for s=1,#oldGenome.synapses
		table.insert(newGenome.synapses, copySynapse(oldGenome.synapses[s]))
	end

	--Copy the max neuron over
	newGenome.maxNeuron = oldGenome.maxNeuron

	return newGenome
end