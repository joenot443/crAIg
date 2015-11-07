require("NEAT/util/calculateCompatibilityDistance")

-- Reorganize genomes into species
function reSpeciate(crAIg)
	--Each species needs a candidate (a random genome from the previous generation's species)

	local unorganizedGenomes = {}
	for i=1,#crAIg.species do
		local currentSpecies = crAIg.species[i]

		--Drop all genomes except the candidate
		for j=1,#currentSpecies.genomes do
			if currentSpecies.genomes[j] ~= currentSpecies.candidateGenome then
				local removeGenome = table.remove(currentSpecies.genomes,j)
				table.insert(unorganizedGenomes,removeGenome)
			end
		end
	end

	--Add the genomes back into the species which it matches most closely
	for i=1,#unorganizedGenomes do

		local unorganizedGenome = unorganizedGenomes[i]
		local gotPlaced = false

		for j=1,#crAIg.species do
			local candidateGenome = crAIg.species[j].candidateGenome
			local compatibilityDistance = calculateCompatibilityDistance(unorganizedGenome,candidateGenome)

			print("Compatibility Distance: ",compatibilityDistance)
			if(compatibilityDistance <= COMPATIBILITY_THRESHOLD) then
				table.insert(crAIg.species[j].genomes,unorganizedGenome)
				gotPlaced = true
				break
			end
		end

		if not gotPlaced then
			--Create a new species with unorganizedGenome as its candidateGenome
			local newSpecies = Species:new()
			table.insert(newSpecies.genomes,unorganizedGenome)
			newSpecies.candidateGenome = unorganizedGenome

			table.insert(crAIg.species,newSpecies)
		end
	end
end