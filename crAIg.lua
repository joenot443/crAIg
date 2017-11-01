package.path = package.path .. ";/Users/joecrozier/Development/crAIg/?.lua;/Users/joecrozier/Development/crAIg/runtime/;"
-- pretty = require "pl.pretty".dump
function pretty(str)
	return str
end

--Initialize math.random()
math.randomseed(os.time())
math.random()

require("NEAT/newGeneration")
require("NEAT/models/Genome")
require("NEAT/mutateGenome")
require("NEAT/models/Species")
require("runtime/chooseOutputs")
require("runtime/marioCraig")

require("NEAT/util/deepFitnessCalculate")
require("runtime/persistence");



local crAIg = {}
crAIg.species = {}
crAIg.generation = 0


--Give crAIg a seed species
local seedSpecies = Species:new()

--Give crAIg a random genome
local randomGenome = Genome:new()
mutateAddSynapse(randomGenome)

table.insert(seedSpecies.genomes,randomGenome)
table.insert(crAIg.species,seedSpecies)

--Uncomment to load a previous iteration of crAIg
--crAIg = persistence.load("runtime/crAIgs/crAIg-saved-39.lua")

local numGenerations = 1000
for i=1,numGenerations do
	newGeneration(crAIg)

	--Save crAIg
	local crAIgName = "runtime/crAIgs/crAIg-saved-"..crAIg.generation..".lua";
	persistence.store(crAIgName, crAIg);
end
