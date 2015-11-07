require("NEAT/util/deepFitnessCalculate")
require("NEAT/extinction")
require("NEAT/matingSeason")
require("NEAT/reSpeciate")
require("NEAT/survivalOfTheFittest")

--Evolve crAIg into the next generation
function newGeneration(crAIg)
	-- 1. Calculate Fitness of all genomes and species
	-- 		Pick a species "candidate genome"
	print("Calculating deep fitness for ",#crAIg.species, " species")
	for s=1,#crAIg.species do
		deepFitnessCalculate(crAIg.species[s])
	end


	print("Running survival of the fittest for ",#crAIg.species, " species")
	-- 2. Survival of the Fittest
	for s=1,#crAIg.species do
		survivalOfTheFittest(crAIg.species[s])
	end

	print("Simulating extinction for ",#crAIg.species, " species")
	-- 3. Remove any species that have been around for too long without being good
	extinction(crAIg.species)

	-- 4. Remove any species that are so weak they're without hope (?)

	print("Simulating mating season for ",#crAIg.species, " species")
	-- 5. Make babies!
	for s=1,#crAIg.species do
		matingSeason(crAIg.species[s])
	end

	print("Respeciating among ",#crAIg.species, " species")
	-- 6. Re-organize species accordingly
	reSpeciate(crAIg)

	-- 7. Done!
end