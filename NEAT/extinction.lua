require("NEAT/config")

--A species goes extinct if it's been the worst species for a while
function extinction(allSpecies)
	local keepSpeciesCount = #allSpecies - math.floor(#allSpecies*EXTINCTION_CANDIDATE)

	table.sort(allSpecies, function(a,b)
		return a.averageFitness > b.averageFitness
	end)

	--For each of the species that aren't making the bar
	print("\tKeeping ",keepSpeciesCount," species (out of ",#allSpecies,")")
	for s=keepSpeciesCount+1,#allSpecies do
		local species = allSpecies[s]

		species.extinctionCounter = species.extinctionCounter + 1

		if species.extinctionCounter >= EXTINCTION_GENERATIONS then
			--Gotta kill it
			table.remove(allSpecies,s)
		end
	end
end