--Pretty print

require("NEAT/mutateGenome")

--Fill the population as necessary with children
--Number of children based off species.populationSize
function matingSeason(species)
	local child = Genome:new()
	local babyCount = species.populationSize - #species.genomes

	print("\tSpecies ",species.id," making ",babyCount," babies")

	for i=1,babyCount do

		--Asexually reproduce by chance or if there is only one parent
		if math.random() < ASEXUAL_REPRODUCTION_CHANCE or #species.genomes == 1 then
			--Copy a parent genome exactly
			--print("\tAsexual reproduction")
			local parent = species.genomes[math.random(1,#species.genomes)]

			child = Genome:copy(parent)
		else
			--Mate
			--print("\tSexual reproduction",#species.genomes)
			local momIndex = math.random(1,#species.genomes)
			local mom = species.genomes[momIndex]
			local dad = findPartner(momIndex,species.genomes)

			child = mate(mom,dad)
		end

		mutateGenome(child)

		--Add the baby
		table.insert(species.genomes,child)
	end
end

--Crossover
--return a child
function mate(momGenome, dadGenome)
	local child = Genome:new()

	--Foreplay
	--Organize parent synapses by historical marking
	local momSynapses = {}
	for i=1,#momGenome.synapses do
		local synapse = momGenome.synapses[i]
		momSynapses[synapse.historicalMarking] = synapse
	end

	local dadSynapses = {}
	for i=1,#dadGenome.synapses do
		local synapse = dadGenome.synapses[i]
		dadSynapses[synapse.historicalMarking] = synapse
	end
	--Now we have two arrays that we can match up

	--The dirty
	--Look through all of the mom's synapses to find matches
	for historicalMarking,momSynapse in pairs(momSynapses) do
		local dadSynapse = dadSynapses[historicalMarking]

		if dadSynapse ~= nil then
			--There is a matching synapse. Use the synapse from the fitter parent
			if momGenome.fitness > dadGenome.fitness then
				table.insert(child.synapses, momSynapse)
			elseif dadGenome.fitness > momGenome.fitness then
				table.insert(child.synapses, dadSynapse)
			else
				--They have the same fitness, random
				if math.random(2) == 1 then
					table.insert(child.synapses, momSynapse)
				else
					table.insert(child.synapses, dadSynapse)
				end
			end
		else
			--Disjoint or Excess NEAT gene. Only keep if it's the fitter parent
			if momGenome.fitness > dadGenome.fitness then
				table.insert(child.synapses, momSynapse)
			elseif momGenome.fitness == dadGenome.fitness then
				--If they're the same fitness, randomly decide to keep or not
				if math.random(2) ==1 then
					table.insert(child.synapses, momSynapse)
				end
			end
		end
	end

	--Now look through the dad's synapses to find any that aren't in mom
	for historicalMarking,dadSynapse in pairs(dadSynapses) do
		local momSynapse = momSynapses[historicalMarking]

		--We've already got matching ones, so only do stuff if its not matching
		if momSynapse == nil then
			if dadGenome.fitness > momGenome.fitness then
				table.insert(child.synapses, dadSynapse)
			elseif dadGenome.fitness == momGenome.fitness then
				if math.random(2) == 1 then
					table.insert(child.synapses, dadSynapse)
				end
			end
		end
	end

	--Post-coitus
	--Calculate the child's max neuron
	for s=1,#child.synapses do 
		if(child.synapses[s].to > child.maxNeuron) then
			child.maxNeuron = child.synapses[s].to
		end

		if(child.synapses[s].from > child.maxNeuron) then
			child.maxNeuron = child.synapses[s].from
		end
	end

	return child
end

--Make find a genome from a set of genomes that doesn't have the same index as the other parent
function findPartner(parentIndex, genomes)
	local partnerIndex = math.random(1,#genomes)

	if partnerIndex == parentIndex then
		--We need to change the partner index by either incrementing it or making it the first in the array
		if partnerIndex == #genomes then
			partnerIndex = 1
		else
			partnerIndex = partnerIndex + 1
		end
	end

	return genomes[partnerIndex]
end