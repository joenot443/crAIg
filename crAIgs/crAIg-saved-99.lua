-- Persistent Data
local multiRefObjects = {
{};
} -- multiRefObjects
multiRefObjects[1]["fitness"] = 0;
multiRefObjects[1]["adjustedFitness"] = 0;
multiRefObjects[1]["maxNeuron"] = 176;
multiRefObjects[1]["synapses"] = {
	[1] = {
		["historicalMarking"] = 1;
		["type"] = 1;
		["to"] = 176;
		["from"] = 111;
		["weight"] = 0;
		["enabled"] = true;
		["lit"] = false;
	};
	[2] = {
		["historicalMarking"] = 2;
		["type"] = 1;
		["to"] = 170;
		["from"] = 112;
		["weight"] = 0;
		["enabled"] = true;
		["lit"] = false;
	};
	[3] = {
		["historicalMarking"] = 3;
		["type"] = 1;
		["to"] = 173;
		["from"] = 112;
		["weight"] = 0;
		["enabled"] = true;
		["lit"] = false;
	};
};
multiRefObjects[1]["id"] = 4;
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
	["generation"] = 99;
}
return obj1
