--If allowInput, it can return an input neuron
function randomNeuron(neurons, allowInput)
	local startValue = 1

	if not allowInput then
		startValue += INPUT_COUNT
	end

	--Count the number of neurons
	local neuronCount
	for _,_ in pairs(neurons) do
		neuronCount += 1
	end

	local neuronNumber = math.random(startValue, neuronCount)

	return neurons[neuronNumber]
end