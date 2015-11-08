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

	function sendGrid() {
		console.log("Sending grid");
		var fs = require('fs');
		var grid = JSON.parse(fs.readFileSync('graph.json', 'utf8'));
		socket.emit('grid', grid);
	}

	function sendSynapses() {
		console.log("Sending synapses");
		var fs = require('fs');
		var synapses = JSON.parse(fs.readFileSync('network.json', 'utf8'));
		socket.emit('synapses', synapses);
	}

});

