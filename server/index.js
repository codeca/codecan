var Player = require("./Player.js")
var net = require("net")

saveLocalIp()

var server = net.createServer(function (conn) {
	var p = new Player(conn)
	console.log("New connection")
	p.on("message", function (name, data) {
		console.log("Received", name, data)
        p.sendMessage(name, data.toUpperCase())
	})
	p.on("close", function () {
		console.log("Connection closed")
	})
})
server.listen(8001)
server.on("listening", function () {
	console.log('Server up and running')
})

function saveLocalIp() {
	// Get the local ip for this machine and send to the server
	require("child_process").exec("ifconfig", function (error, stdout, stderr) {
		var ips
		if (error)
			throw new Error("Error")
		
		// Get all ips
		ips = stdout.toString().match(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g)
		if (!ips)
			throw new Error("Ip not found")
        
		// Send to server
		console.log("Saving your local ip ("+ips[1]+")...")
		require("http").get({
			hostname: "sitegui.com.br",
			path: "/codecan/setIp.php?ip="+ips[1],
			agent: false}, function (res) {
				if (res.statusCode != 200)
					throw new Error("Error in the request")
		}).once("close", function () {
            console.log("Saved")
        })
	})
}
