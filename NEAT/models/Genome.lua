Genome = {}

function Genome:new()
	local genome = {}

	-- Fill with Synapse objects
	-- We can build a network using only synapse objects by adding neurons when they are referenced.
	genome.synapses = {}

	--This represents the label of the largest Neuron in this Genome.
	--We keep track of this so that we can easily add synapses
	genome.maxNeuron = 0

	return genome
end