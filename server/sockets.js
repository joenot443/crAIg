var app = require('./app');
var http = require('http');
var server = http.Server(app.app);
var io = require('socket.io')(server);

function initServer() {

	server.listen(5252);

	io.on('connection', function (socket) {
		console.log("someone connected");
	});
}