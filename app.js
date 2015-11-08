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
	setInterval(sendGrid, 500);
	setInterval(sendSynapsesUpdate, 500);

	function sendGrid() {
		console.log("Sending grid");
		var graph = fs.readFileSync("graph.json");
		try {
			var grid = JSON.parse(graph);
			socket.emit('grid', grid);
		} catch(e){
			console.log("Skipping send because file un-parseable");
		}
	}

	function sendSynapses() {
		console.log("Sending synapses");
		try {
			var synapses = JSON.parse(fs.readFileSync('network.json', 'utf8'));
			socket.emit('synapses', synapses);
		} catch(e){
			console.log("Skipping send because file un-parseable 2");
		}
	}
	sendSynapses();

	function sendSynapsesUpdate(){
		console.log("Sending synapses update");
		try {
			var synapses = JSON.parse(fs.readFileSync('litmap.json', 'utf8'));
			socket.emit('synapses_update', synapses);
		} catch(e){
			console.log("Skipping send because file un-parseable 3");
		}
	}

});

