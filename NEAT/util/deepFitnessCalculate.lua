--Calculate fitness for each genome in the species
--Pick a candidate genome for each species
function deepFitnessCalculate(species)
	print("Calculating fitness for ",#species.genomes," genomes")
	for i=1,#species.genomes do
		local genome = species.genomes[i]
		genome.fitness = calculateFitness(genome)
	end

	setCandidate(species)
end

function calculateFitness(genome)
	--This is where mario comes in
	return 1
end

function setCandidate(species)
	-- Random selection
	local selectedGenome = math.random(1,#species.genomes)
	print("\tSelected genome ",selectedGenome," as candidate")
	species.candidateGenome = species.genomes[selectedGenome]
end