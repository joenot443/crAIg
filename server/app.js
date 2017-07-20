var express = require('express');
var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var fs = require('fs');
var _ = require('underscore');

server.listen(3000);

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
	setInterval(sendGrid, 500);
	setInterval(sendSynapsesUpdate, 500);
	setInterval(checkSendSynapses, 100);

	socket.emit("test", {hello: "world"});

	var lastGenome = 0;
	var currentGrid = {};
	var currentSynapseUpdate = {};

	function sendGrid() {
		var graph = fs.readFileSync("../runtime/live/graph.json");

		try {
			var grid = JSON.parse(graph);
			if (!_.isEqual(grid, currentGrid)) {
				currentGrid = grid;
				console.log("Sending grid");
				socket.emit('grid', grid);
			}
		} catch(e){
			console.log(e);
			console.log("Skipping send because file un-parseable");
		}
	}
	//Check if we need to send new synapses
	function checkSendSynapses() {
		var fs = require('fs');
		try{
		var synapses = JSON.parse(fs.readFileSync('../runtime/live/network.json', 'utf8'));
		if (synapses.genome != lastGenome) {
			
			console.log("Sending a new synapse for " + synapses.genome);
			socket.emit('synapses', synapses);
			lastGenome = synapses.genome;
		};
	}	catch(e){

		}
	}

	function sendSynapsesUpdate(){
		try {
			var synapses = JSON.parse(fs.readFileSync('../runtime/live/litmap.json', 'utf8'));
			if (!_.isEqual(synapses, currentSynapseUpdate)) {
				console.log("Sending synapses update");
				currentSynapseUpdate = synapses;
				socket.emit('synapses_update', currentSynapseUpdate);
			}
		} catch(e){
			console.log("Skipping send because file un-parseable 3");
		}
	}

});

