var express = require('express');
var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var fs = require('fs');

server.listen(80);

//Serve static files
app.use(express.static('public'));

//localhost will lead to craig.html
app.get('/', function (req, res) {
  res.sendfile(__dirname + '/public/craig.html');
});

//Sockets
io.on('connection', function (socket) {
	console.log("Someone connected!");

	//Set up a timer to send the JSON file
	setInterval(sendGrid, 100);
	setInterval(sendSynapsesUpdate, 100);
	setInterval(checkSendSynapses, 100);

	var lastGenome = 0;
	function sendGrid() {
		console.log("Sending grid");
		var fs = require('fs');
		var grid = JSON.parse(fs.readFileSync('graph.json', 'utf8'));
		socket.emit('grid', grid);
	}
	//Check if we need to send new synapses
	function checkSendSynapses() {
		console.log("Checking if we need to send new synapses");
		var fs = require('fs');
		var synapses = JSON.parse(fs.readFileSync('network.json', 'utf8'));
		if (synapses.genome != lastGenome) {
			console.log("Sending a new synapse for " + synapses.genome);
			socket.emit('synapses', synapses);
			lastGenome = synapses.genome;
		};
	}
	checkSendSynapses();

	function sendSynapsesUpdate(){
		console.log("Sending synapses update");
		var fs = require('fs');
		var synapses = JSON.parse(fs.readFileSync('litmap.json', 'utf8'));
		socket.emit('synapses_update', synapses);
	}

});

