--If allowInput, it can return an input neuron
function getRandomNeuron(neurons, allowInput, previousLabel)
	local startValue = 50

	if not allowInput then
		startValue = 1 + INPUT_COUNT
	end

	--Count the number of neurons
	local neuronCount = 0
	for id,neuron in pairs(neurons) do
		neuronCount = neuronCount + 1
	end

	local neuronNumber = math.random(startValue, neuronCount)

	if neuronNumber < 169 then
		print("Picking internior input neuron ");
		local neuronYNumber = math.random(3, 6)
		local neuronXNumber = math.random(5, 10)

		local neuronNumber = neuronYNumber * 13 + neuronXNumber;
	end

	print("New neuron number: "..neuronNumber);

	local neuron = neurons[neuronNumber]

	if(neuron.label == previousLabel) then
		return getRandomNeuron(neurons,allowInput,previousLabel)
	else
		return neuron
	end
end	