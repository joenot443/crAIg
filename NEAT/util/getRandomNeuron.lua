require("NEAT/config")

--If allowInput, it can return an input neuron
function getRandomNeuron(neurons, allowInput, previousLabel)
	print("# neurons: ",#neurons)
	local startValue = 1

	if not allowInput then
		startValue = 1 + INPUT_COUNT
	end

	--Count the number of neurons
	local neuronCount = 0
	for id,neuron in pairs(neurons) do
		neuronCount = neuronCount + 1
	end

	local neuronNumber = math.random(startValue, neuronCount)

	if MODDED_ALGORITHM then
		if neuronNumber < 169 then
			local neuronYNumber = math.random(7, 10)
			local neuronXNumber = math.random(5, 10)

			neuronNumber = neuronYNumber * 13 + neuronXNumber;
		end

		if neuronNumber == 172 then
			neuronNumber = 174
		elseif neuronNumber == 173 then
			neuronNumber = 171
		end
	end


	local neuron = neurons[neuronNumber]

	if(neuron.label == previousLabel) then
		return getRandomNeuron(neurons,allowInput,previousLabel)
	else
		return neuron
	end
end	