--Take a species and clear out the weak
function survivalOfTheFittest(species)
	--Sort them by fitness (maybe we should have calculated fitness beforehand?)
	table.sort(species.genomes, function(a,b)
		return (a.fitness > b.fitness)
	end)

	local theWeakCount -- Use function 2 from the paper

	local thoseWhoSurvived = #species - theWeakCount

	--Check for fitness over time (if it's been 20 generations without change, only keep top 2)

	--Remove the necessary species
	while #species > thoseWhoSurvived do
		table.remove(species)
	end
end