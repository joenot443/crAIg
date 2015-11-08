require("NEAT/util/deepFitnessCalculate")
require("NEAT/extinction")
require("NEAT/matingSeason")
require("NEAT/reSpeciate")
require("NEAT/survivalOfTheFittest")
require("NEAT/util/calculateAdjustedFitnesses")

--Evolve crAIg into the next generation
function newGeneration(crAIg)
	print("-------------GENERATION----------------")
	-- 1. Calculate Fitness of all genomes and species
	-- 		Pick a species "candidate genome"
	print("Calculating deep fitness for ",#crAIg.species, " species")
	for s=1,#crAIg.species do
		deepFitnessCalculate(crAIg.species[s],crAIg)
	end

	-- 2. Calculate the adjusted fitnesses of all genomes
	print("Calculating adjusted fitnesses for ",#crAIg.species, " species")
	crAIg.totalAdjustedFitness = calculateAdjustedFitnesses(crAIg)


	print("Running survival of the fittest for ",#crAIg.species, " species")
	-- 3. Survival of the Fittest
	for s=1,#crAIg.species do
		survivalOfTheFittest(crAIg.species[s], crAIg.totalAdjustedFitness)
	end

	print("Simulating extinction for ",#crAIg.species, " species")
	-- 4. Remove any species that have been around for too long without being good
	extinction(crAIg.species)

	-- 5. Remove any species that are so weak they're without hope (?)

	print("Simulating mating season for ",#crAIg.species, " species")
	-- 6. Make babies!
	for s=1,#crAIg.species do
		matingSeason(crAIg.species[s])
	end

	print("Respeciating among ",#crAIg.species, " species")
	-- 7. Re-organize species accordingly
	reSpeciate(crAIg)

	print("Final species count: ",#crAIg.species)

	-- 8. Done!
	print("-------------GENERATION DONE---------------")
end