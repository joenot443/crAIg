function getLargerGenome(genome1,genome2)
	if #genome1.synapses > #genome2.synapses then
		return genome1
	else
		return genome2
	end
end