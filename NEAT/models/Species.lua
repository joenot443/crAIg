Species = {}

function Species:new()
	local species = {}

	species.topFitness
	species.staleness

	-- How many genomes are there supposed to be in this species?
	species.populationSize

	-- Fill with Genome objects
	species.genomes = {}

	species.averageFitness = 0

	return species
end