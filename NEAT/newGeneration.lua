--Evolve crAIg into the next generation
function newGeneration()
	-- 1. Calculate Fitness of all genomes and species
	-- 		Pick a species "candidate genome"

	-- 2. Survival of the Fittest
	for s=1,#crAIg.species do
		survivalOfTheFittest(crAIg.species[s])
	end

	-- 3. Remove any species that have been around for too long without being good
	extinction(crAIg.species)

	-- 4. Remove any species that are so weak they're without hope (?)

	-- 5. Make babies!
	for s=1,#crAIg.species do
		matingSeason(crAIg.species[s])
	end

	-- 6. Re-organize species accordingly
	reSpeciate(crAIg.species)

	-- 7. Done!
end