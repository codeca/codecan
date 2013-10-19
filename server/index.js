var Player = require("./Player.js")
var net = require("net")
var Game = require("./Game.js")

// Store player in the matching room
var playersWaiting3 = []
var playersWaiting4 = []

// Return the union of two arrays
function unite(a, b) {
	return a.concat(b.filter(function (x) {
		return a.indexOf(x) == -1
	}))
}

// Return the array a without the elements of b
// Same of A - B (A and B as sets)
function getDifference(a, b) {
	return a.filter(function (x) {
		return b.indexOf(x) == -1
	})
}

// Try to remove an element from an array
function removeFromArray(a, el) {
	var pos = a.indexOf(el)
	if (pos != -1)
		a.splice(pos, 1)
}

// Try to match players in the waiting line
function matchPlayers(newPlayer) {
	// Try to find a match with 4 players
	if (newPlayer.want4) {
		playersWaiting4.push(newPlayer)
		if (playersWaiting4.length == 4) {
			// Match with 4 found
			games.push(new Game(playersWaiting4))
			playersWaiting3 = getDifference(playersWaiting3, playersWaiting4)
			playersWaiting4 = []
			return
		}
	}

	// Try to find a match with 3 players
	if (newPlayer.want3) {
		playersWaiting3.push(newPlayer)
		if (playersWaiting3.length == 3) {
			// Match with 3 found
			games.push(new Game(playersWaiting3))
			playersWaiting4 = getDifference(playersWaiting4, playersWaiting3)
			playersWaiting3 = []
			return
		}
	}
}

// Tell all the current players waiting the current number of players in each ground
function informMatchingProgress() {
	var data = [playersWaiting3.length, playersWaiting4.length]
	Player.broadcast(unite(playersWaiting3, playersWaiting4), "matchStatus", data)
}

// Treat each client message
function onmessage(name, data) {
	if (this.game) {
		// Broadcast the message
		Player.broadcast(this.game.players, name, data, this)
	} else {
		// Add the current player to the matching list
		this.want3 = Boolean(data.want3)
		this.want4 = Boolean(data.want4)
		this.name = String(data.name)
		this.id = String(data.id)
		matchPlayers(this)
		informMatchingProgress()
	}
}

// Treat a player disconnection
function onclose() {
	if (this.game) {
		// Inform all the players in the game the player has disconnected
		removeFromArray(this.game.players, this)
		Player.broadcast(this.game.players, "disconnected", this.id)
	} else {
		// Remove from the queue
		removeFromArray(playersWaiting3, this)
		removeFromArray(playersWaiting4, this)
		informMatchingProgress()
	}
}

// Treat each new connection
function onconnect(conn) {
	var p = new Player(conn)
	p.on("message", onmessage)
	p.once("close", onclose)
}

// Create the server and start listening
net.createServer(onconnect).listen(8001)

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
	console.log("Saving your local ip (" + ips[1] + ")...")
	require("http").get({
		hostname: "sitegui.com.br",
		path: "/codecan/setIp.php?ip=" + ips[1],
		agent: false
	}, function (res) {
		if (res.statusCode != 200)
			throw new Error("Error in the request")
	}).once("close", function () {
		console.log("Saved")
	})
})
