require("NEAT/models/Synapse")
require("NEAT/models/Neuron")
require("NEAT/models/Species")
require("NEAT/models/Genome")

-- A 	= 170;
-- B 	= 171;
-- LEFT 	= 172;
-- RIGHT	= 173;

----Generate the species
local species = Species:new()

local genome1 = Genome:new()
genome1.maxNeuron = 8
	-- A>D
	local synapse1 = Synapse:new()
	synapse1.historicalMarking = 1
	synapse1.from = 1
	synapse1.to = 4
	table.insert(genome1.synapses, synapse1)

	-- B>D
	local synapse2 = Synapse:new()
	synapse2.historicalMarking = 2
	synapse2.from = 2
	synapse2.to = 4
	synapse2.enabled = false
	table.insert(genome1.synapses, synapse2)

	-- C>D
	local synapse3 = Synapse:new()
	synapse3.historicalMarking = 3
	synapse3.from = 3
	synapse3.to = 4
	table.insert(genome1.synapses, synapse3)

	-- B>E
	local synapse4 = Synapse:new()
	synapse4.historicalMarking = 4
	synapse4.from = 2
	synapse4.to = 5
	table.insert(genome1.synapses, synapse4)

	-- E>D
	local synapse5 = Synapse:new()
	synapse5.historicalMarking = 5
	synapse5.from = 5
	synapse5.to = 4
	table.insert(genome1.synapses, synapse5)

	-- A>E
	local synapse8 = Synapse:new()
	synapse8.historicalMarking = 8
	synapse8.from = 1
	synapse8.to = 5
	table.insert(genome1.synapses, synapse8)

local genome2 = Genome:new()
genome2.maxNeuron = 10
	-- A>D
	table.insert(genome2.synapses, Synapse:copy(synapse1))

	-- B>D
	table.insert(genome2.synapses, Synapse:copy(synapse2))

	-- C>D
	table.insert(genome2.synapses, Synapse:copy(synapse3))

	-- B>E
	table.insert(genome2.synapses, Synapse:copy(synapse4))

	-- E>D
	synapse5.enabled = false
	table.insert(genome2.synapses, Synapse:copy(synapse5))

	-- A>E
	local synapse6 = Synapse:new()
	synapse6.historicalMarking = 6
	synapse6.from = 5
	synapse6.to = 6
	table.insert(genome2.synapses,synapse6)

	-- E>F
	local synapse7 = Synapse:new()
	synapse7.historicalMarking = 7
	synapse7.from = 6
	synapse7.to = 4
	table.insert(genome2.synapses,synapse7)

	-- C>E
	local synapse9 = Synapse:new()
	synapse9.historicalMarking = 9
	synapse9.from = 3
	synapse9.to = 5
	table.insert(genome2.synapses,synapse9)

	-- A>F
	local synapse10 = Synapse:new()
	synapse10.historicalMarking = 10
	synapse10.from = 1
	synapse10.to = 6
	table.insert(genome2.synapses,synapse10)


local genome3 = Genome:new()
genome3.maxNeuron = 4
	-- A>D
	table.insert(genome3.synapses, Synapse:copy(synapse1))

	-- B>D
	table.insert(genome3.synapses, Synapse:copy(synapse2))

	-- C>D
	table.insert(genome3.synapses, Synapse:copy(synapse3))

	-- B>E
	table.insert(genome3.synapses, Synapse:copy(synapse4))

local genome4 = Genome:new()
genome4.maxNeuron = 176

local synapse10 = Synapse:new()
	synapse10.historicalMarking = 1
	synapse10.from = 111
	synapse10.to = 176
	table.insert(genome4.synapses, synapse10)
local synapse10 = Synapse:new()
	synapse10.historicalMarking = 2
	synapse10.from = 112
<<<<<<< HEAD
	synapse10.to = 176
=======
	synapse10.to = 170
>>>>>>> 86783108ac857fdc2155b06c6730429943d2f5d1
	table.insert(genome4.synapses, synapse10)
local synapse10 = Synapse:new()
	synapse10.historicalMarking = 3
	synapse10.from = 112
	synapse10.to = 173
	table.insert(genome4.synapses, synapse10)



-- table.insert(species.genomes,genome1)
-- table.insert(species.genomes,genome2)
table.insert(species.genomes,genome4)



function getCraig()
	local craig = {}
	craig.species = {}
	table.insert(craig.species,species)
	return craig
end