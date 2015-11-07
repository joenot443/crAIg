Species = {}

function Species:new()
	local species = {}

	-- How many genomes are there supposed to be in this species?
	species.populationSize = 0

	-- Fill with Genome objects
	species.genomes = {}

	-- Determined by a function?
	species.averageFitness = 0

	-- Set by calculateAdjustedFitness()
	species.sumAdjustedFitness = 0

	-- How long has this species been underperforming (generations)
	species.extinctionCounter = 0

	-- Which genome are we using as a metric for which genomes are part of this species or not
	species.candidateGenome = {}

	return species
end