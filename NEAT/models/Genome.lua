Genome = {}

function Genome:new()
	local genome = {}

	-- Fill with Synapse objects
	-- We can build a network using only synapse objects by adding neurons when they are referenced.
	genome.synapses = {}

	return genome
end