-- Persistent Data
local multiRefObjects = {
{};
} -- multiRefObjects
multiRefObjects[1]["fitness"] = 0;
multiRefObjects[1]["adjustedFitness"] = 0;
multiRefObjects[1]["maxNeuron"] = 175;
multiRefObjects[1]["synapses"] = {
	[1] = {
		["historicalMarking"] = 1;
		["type"] = 2;
		["to"] = 170;
		["from"] = 137;
		["weight"] = 0.125278481399;
		["enabled"] = true;
		["lit"] = false;
	};
};
multiRefObjects[1]["id"] = 1;
local obj1 = {
	["totalAdjustedFitness"] = 0;
	["species"] = {
		[1] = {
			["candidateGenome"] = multiRefObjects[1];
			["genomes"] = {
				[1] = multiRefObjects[1];
			};
			["id"] = 1;
			["sumAdjustedFitness"] = 0;
			["populationSize"] = -1.#IND;
			["averageFitness"] = 0;
			["extinctionCounter"] = 0;
		};
	};
	["generation"] = 34;
}
return obj1
