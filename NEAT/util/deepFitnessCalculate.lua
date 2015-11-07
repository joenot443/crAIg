--Calculate fitness for each genome in the species
--Pick a candidate genome for each species
function deepFitnessCalculate(species)
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
	species.candidateGenome = species.genomes[math.random(1,#species.genomes)]
end