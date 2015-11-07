Species = {}

function Species:new()
	local species = {}

	species.topFitness
	species.staleness

	-- Fill with Genome objects
	species.genomes = {}

	species.averageFitness = 0

	return species
end