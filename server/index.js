var Player = require("./Player.js")
var net = require("net")

var server = net.createServer(function (conn) {
	var p = new Player(conn)
	console.log("New connection")
	p.on("message", function (name, data) {
		console.log("Received", name, data)
	})
	p.on("close", function () {
		console.log("Connection closed")
	})
})
server.listen(8001)
server.on("listening", function () {
	console.log('Server up and running')
})

setTimeout(function () {
	var conn = net.connect(8001, "localhost", function () {
		var p = new Player(conn)
		p.sendMessage("pi", [3, 14, 15, 92, 65])
		setTimeout(function () {
			p.close()
		}, 2e3)
	})
}, 2e3)
