require("NEAT/util/calculateCompatibilityDistance")
require("NEAT/config")

function calculateAdjustedFitnesses(crAIg)

	local totalSumAdjustedFitnesses = 0

	--Shortcut method
	for s=1,#crAIg.species do
		local species = crAIg.species[s]
		species.sumAdjustedFitness = 0

		for g=1, #species.genomes do
			local genome = species.genomes[g]
			genome.adjustedFitness = genome.fitness / #species.genomes

			species.sumAdjustedFitness = species.sumAdjustedFitness + genome.adjustedFitness

			totalSumAdjustedFitnesses = totalSumAdjustedFitnesses + species.sumAdjustedFitness
		end
	end

	return totalSumAdjustedFitnesses

	--Below is the actual implementation. As mentioned in the paper, the sharing function simplifies itself within species
	--[[
	for s=1,#crAIg.species do
		local species = crAIg.species[s]

		for g=1, #species.genomes do
			local genome = species.genomes[g]
			genome.adjustedFitness = genomeAdjustedFitness(genome, crAIg)
		end
	end
	--]]
end

function genomeAdjustedFitness(genome, crAIg)
	local fitness = genome.fitness
	local sum = 0

	for s=1,#crAIg.species do
		local species = crAIg.species[s]
		
		for g=1, #species.genomes do
			local compareGenome = species.genomes[g]
			local compatibilityDistance = calculateCompatibilityDistance(compareGenome, genome)
			local sh = 1
			if compatibilityDistance>COMPATIBILITY_THRESHOLD then
				sh = 0
			end
			sum = sum + sh
		end
	end

	return fitness/sum;
end