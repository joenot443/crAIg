--Calculate fitness for each genome in the species
--Pick a candidate genome for each species
function deepFitnessCalculate(species)
	print("Calculating fitness for species ",species.id)
	for i=1,#species.genomes do
		local genome = species.genomes[i]
		synapses = genome.synapses;
		print("\t\tGenome: ",genome.id)
		genome.fitness = calculateFitness(genome)
		firstRun = true;
		print("\t\t\tFitness: ",genome.fitness)
	end

	--Set the representative for the species
	setCandidate(species)
	return
end


function calculateFitness(genome)
	local lastX = 0;
	local running = true;
	local framesSinceProgress = 0;
	local tiles = initialState();

	while (running) do
		local outputs = chooseOutputs(genome.synapses, tiles)
		local currentPosition = getMarioXPos();

		if currentPosition <= lastX then
			framesSinceProgress = framesSinceProgress + 1;
		else
 			framesSinceProgress = 0;
			lastX = currentPosition;
		end

		if framesSinceProgress > 50 then
			running = false;
		end

		tiles = runFrame(outputs, genome);
	end	


	return fitness(getMarioXPos()) 
end

function fitness(xpos)
	return xpos
end

function getMarioXPos() 
	return memory.readbyte(0x6D) * 0x100 + memory.readbyte(0x86);
end

function setCandidate(species)
	-- Random selection
	local selectedGenome = math.random(1,#species.genomes)
	print("\tSelected genome ",species.genomes[selectedGenome].id," as candidate")
	species.candidateGenome = species.genomes[selectedGenome]
end