--Enable this if you want to use the slightly modified algorithm that tends to learn to play mario slightly faster
MODDED_ALGORITHM = true

--Children per gen
BABIES_PER_GENERATION = 20

--Probabilities of different mutations occuring
SYNAPSE_WEIGHT_MUTATION_CHANCE = 0.8
ADD_SYNAPSE_MUTATION_CHANCE = 1.0
ADD_NEURON_MUTATION_CHANCE = 0.3

--When mutating a synapse, chance that we perturb it uniformly or randomize
SYNAPSE_WEIGHT_PERTURB_MUTATION_CHANCE = 0.9
SYNAPSE_WEIGHT_RANDOM_MUTATION_CHANCE = 0.1

--When a Synapse weight is perturbed, how much do we perturb it by?
SYNAPSE_PERTURBATION_BIAS = 0.1

--What is the chance that if one parent has a synapse disabled that the child will have it disabled as well
SYNAPSE_INHERIT_DISABLED_CHANCE = 0.75

--Chance of a baby just being a mutation of a parent instead of a crossover mating
ASEXUAL_REPRODUCTION_CHANCE = 0.25

--If you're in the bottom {EXTINCTION_CANDITATE}%, then mark for extinction in {EXTINCTION GENERATIONS} generations
EXTINCTION_GENERATIONS = 3
EXTINCTION_CANDIDATE = 0.4

--Used in equation 1 from the paper
COMPATIBILITY_C1 = 1
COMPATIBILITY_C2 = 1
COMPATIBILITY_C3 = 0.4
SMALL_GENOME_THRESHOLD = 20

--Used to decide if species should be in the same or different species
COMPATIBILITY_THRESHOLD = 5.0

--
FITNESS_WEIGHT = 3

--I/O
OUTPUTS = {
	"L",   		--170
	"R",		--171
	"D",		--172
	"U",		--173
	"A",		--174
	"B",		--175
}
INPUT_COUNT = 169
OUTPUT_COUNT = #OUTPUTS