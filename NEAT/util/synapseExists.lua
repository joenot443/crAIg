-- Check if a specific synapse already exists in a set of synapses
function synapseExists(synapse, synapses)
	for i=1,#synapses do
		local thisSynapse = synapses[i]
		if thisSynapse.from == synapse.from and thisSynapse.to == synapse.to then
			return true
		end
	end

	return false
end