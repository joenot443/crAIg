
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
local crAIg = getCraig()


print(#crAIg.species," species")

for i=1,#crAIg.species do
	local tiles = initialState();
	while (true) do
		print(pretty(tiles))
		local outputs = chooseOutputs(crAIg.species[i].genomes[1].synapses, tiles)
		tiles = runFrame(outputs);

	end
end

--print(pretty(crAIg.species[1].candidateGenome))
--print(pretty(crAIg.species[2].genomes[1]))