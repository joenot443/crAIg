
package.path = package.path .. ";./?.lua"
pretty = require "pl.pretty".dump
math.randomseed(os.time())
math.random()

require("NEAT/newGeneration")
require("testcrAIg")

local crAIg = getCraig()

newGeneration(crAIg)
newGeneration(crAIg)
newGeneration(crAIg)
newGeneration(crAIg)
newGeneration(crAIg)
newGeneration(crAIg)
newGeneration(crAIg)

print(#crAIg.species," species")
for i=1,#crAIg.species do
	print(#crAIg.species[i].genomes, " genomes in species ",i)
end

--print(pretty(crAIg.species[1].candidateGenome))
--print(pretty(crAIg.species[2].genomes[1]))