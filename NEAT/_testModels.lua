--Pretty print
local pretty = require "pl.pretty".dump

require("models/Synapse")
require("models/Neuron")
require("models/Species")
require("models/Genome")

local newSynapse = Synapse:new()
print(pretty(newSynapse))

local newNeuron = Neuron:new()
print(pretty(newNeuron))

local newSpecies = Species:new()
print(pretty(newSpecies))

local newGenome = Genome:new()
print(pretty(newGenome))

print("Test completed.")
