package.path = package.path .. ";./?.lua"
pretty = require "pl.pretty".dump
math.randomseed(os.time())
math.random()

require("NEAT/newGeneration")
require("testcrAIg")

local crAIg = getCraig()

newGeneration(crAIg)

print(#crAIg.species," species")
print(#crAIg.species[1].genomes, " genomes in species 1")

--print(pretty(crAIg))