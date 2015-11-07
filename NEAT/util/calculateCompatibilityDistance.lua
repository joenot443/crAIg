require("NEAT/util/getLargerGenome")

--Calculate the compatibility distance between two genomes
function calculateCompatibilityDistance(genome1,genome2)
	--Equation 1 from the paper
	local E = numExcess(genome1,genome2)
	local D = numDisjoint(genome1,genome2,E)

	local C1 = COMPATIBILITY_C1
	local C2 = COMPATIBILITY_C2
	local C3 = COMPATIBILITY_C3

	local N = #getLargerGenome(genome1,genome2).synapses

	if(N < SMALL_GENOME_THRESHOLD) then
		N = 1
	end

	local W = calculateW(genome1,genome2)

	--print("E: ",E)
	--print("D: ",D)
	--print("C1: ",C1)
	--print("C2: ",C2)
	--print("C3: ",C3)
	--print("N: ",N)
	--print("W: ",W)

	local compatibilityDistance = (C1*E/N) + (C2*D/N) + C3*W

	return compatibilityDistance
end

--Using excessCount as input to speed up the algorithm and save space
--Hackathon: This could probably be optimized better
function numDisjoint(genome1,genome2,excessCount)

	local disjointCount = 0

	for i=1,#genome1.synapses do
		-- Check if it has a matching synapse
		local foundMatch = false

		for j=1,#genome2.synapses do
			--If the two markings are the same, it's a match
			if genome1.synapses[i].historicalMarking == genome2.synapses[j].historicalMarking then
				foundMatch = true
				break;
			end
		end

		if not foundMatch then
			disjointCount = disjointCount + 1
		end
	end

	--Now do it the other way around as well
	for i=1,#genome2.synapses do
		-- Check if it has a matching synapse
		local foundMatch = false

		for j=1,#genome1.synapses do
			--If the two markings are the same, it's a match
			if genome2.synapses[i].historicalMarking == genome1.synapses[j].historicalMarking then
				foundMatch = true
				break;
			end
		end

		if not foundMatch then
			disjointCount = disjointCount + 1
		end
	end

	--Excess don't match but are categorized differently
	local disjointCount = disjointCount - excessCount

	return disjointCount
end

function numExcess(genome1,genome2)
	local maxHistoricalMarkingGenome1 = 0

	for i=1,#genome1.synapses do
		if genome1.synapses[i].historicalMarking > maxHistoricalMarkingGenome1 then
			maxHistoricalMarkingGenome1 = genome1.synapses[i].historicalMarking
		end
	end

	local maxHistoricalMarkingGenome2 = 0
	for i=1, #genome2.synapses do
		if genome2.synapses[i].historicalMarking > maxHistoricalMarkingGenome2 then
			maxHistoricalMarkingGenome2 = genome2.synapses[i].historicalMarking
		end
	end

	--The genome with the more recent changes
	local recentGenome = {}
	--The most recent change to the less recent genome
	local maxHistoricalMarkingOlderGenome = 0
	if(maxHistoricalMarkingGenome1 > maxHistoricalMarkingGenome2) then
		recentGenome = genome1
		maxHistoricalMarkingOlderGenome = maxHistoricalMarkingGenome2
	else
		recentGenome = genome2
		maxHistoricalMarkingOlderGenome = maxHistoricalMarkingGenome1
	end

	local excessCount = 0
	--Run through each of the synapses
	for i=1,#recentGenome.synapses do
		local synapse = recentGenome.synapses[i]

		--If the synapse we're looking at is newer than the newest in the older genome, then it's excess
		if(synapse.historicalMarking > maxHistoricalMarkingOlderGenome) then
			excessCount = excessCount + 1
		end
	end

	return excessCount
end

--W is the average weight differences of matching synapses (including disabled synapses)
function calculateW(genome1,genome2)
	local weightDifferences = {}

	--Find all matches
	for i=1,#genome1.synapses do
		local synapse1 = genome1.synapses[i]
		for j=1,#genome2.synapses do
			local synapse2 = genome2.synapses[j]
			if synapse1.historicalMarking == synapse2.historicalMarking then
				--It's a match!
				--What's the weight difference?
				local weightDifference = math.abs(synapse1.weight - synapse2.weight)
				table.insert(weightDifferences,weightDifference)
				break
			end
		end
	end

	--Find the average of the weight differences
	local weightDifferenceSum = 0
	for i=1,#weightDifferences do
		weightDifferenceSum = weightDifferenceSum + weightDifferences[i]
	end

	local W = weightDifferenceSum/#weightDifferences

	return W
end