--If allowInput, it can return an input neuron
function getRandomNeuron(neurons, allowInput)
	local startValue = 1

	if not allowInput then
		startValue = INPUT_COUNT
	end

	--Count the number of neurons
	local neuronCount = 0
	for _,_ in pairs(neurons) do
		neuronCount = neuronCount + 1
	end

	local neuronNumber = math.random(startValue, neuronCount)

	return neurons[neuronNumber]
end