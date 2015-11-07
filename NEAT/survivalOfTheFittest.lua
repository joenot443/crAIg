--Take a species and clear out the weak, return how many died
function survivalOfTheFittest(species)
	--Sort them by fitness (maybe we should have calculated fitness beforehand?)
	table.sort(species.genomes, function(a,b)
		return (a.fitness > b.fitness)
	end)

	local theWeakCount = 0 -- Use function 2 from the paper

	local thoseWhoSurvived = #species.genomes - theWeakCount

	--Check for fitness over time (if it's been 20 generations without change, only keep top 2)

	--Remember how many genomes are supposed to be 
	species.populationSize = #species.genomes

	--Remove the necessary species
	while #species.genomes > thoseWhoSurvived do
		table.remove(species.genomes)
	end
end