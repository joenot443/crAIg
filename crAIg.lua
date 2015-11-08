
package.path = package.path .. ";./?.lua"
-- pretty = require "pl.pretty".dump
function pretty(str)
	return str
end
math.randomseed(os.time())
math.random()

require("NEAT/newGeneration")
require("NEAT/models/Genome")
require("NEAT/mutateGenome")
require("NEAT/models/Species")
require("chooseOutputs")
require("marioCraig")

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


local numGenerations = 50
for i=1,numGenerations do
	newGeneration(crAIg)
end

print("Test finished.")

--print(pretty(crAIg.species[1].candidateGenome))
--print(pretty(crAIg.species[2].genomes[1]))