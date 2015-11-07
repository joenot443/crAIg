--Probabilities of different mutations occuring
SYNAPSE_WEIGHT_MUTATION_CHANCE = 0.8
ADD_SYNAPSE_MUTATION_CHANCE = 1.0
ADD_NEURON_MUTATION_CHANCE = 1.0

--When mutating a synapse, chance that we perturb it uniformly or randomize
SYNAPSE_WEIGHT_PERTURB_MUTATION_CHANCE = 0.9
SYNAPSE_WEIGHT_RANDOM_MUTATION_CHANCE = 0.1

--When a Synapse weight is perturbed, how much do we perturb it by?
SYNAPSE_PERTURBATION_BIAS = 0.1

--What is the chance that if one parent has a synapse disabled that the child will have it disabled as well
SYNAPSE_INHERIT_DISABLED_CHANCE = 0.75
