
package.path = package.path .. ";./?.lua"
-- pretty = require "pl.pretty".dump
function pretty(str)
	return str
end
math.randomseed(os.time())
math.random()

require("NEAT/newGeneration")
require("testcrAIg")
require("chooseOutputs")
require("marioCraig")
require("NEAT/util/deepFitnessCalculate")

local crAIg = getCraig()


newGeneration(crAIg);

print("Test finished.")

--print(pretty(crAIg.species[1].candidateGenome))
--print(pretty(crAIg.species[2].genomes[1]))