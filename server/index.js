var Player = require("./Player.js")
var net = require("net")
var Game = require("./Game.js")

// Store player in the matching room
var playersWaiting3 = []
var playersWaiting4 = []

// Message type constants
var MSG_MATCH = -4
var MSG_MATCH_PROGRESS = -3
var MSG_MATCH_DONE = -2
var MSG_PLAYER_DISCONNECTED = -1

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
			createRoom(playersWaiting4)
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
			createRoom(playersWaiting3)
			playersWaiting4 = getDifference(playersWaiting4, playersWaiting3)
			playersWaiting3 = []
			return
		}
	}
}

// Send the given message to all the players in the array
// ignoreThis is a player to whon the message won't be sent (optional)
function broadcast(players, type, data, ignoreThis) {
	players.forEach(function (p) {
		if (p != ignoreThis)
			p.sendMessage(type, data)
	})
}

// Create a room with the given players
function createRoom(players) {
	var game, data

	// Create the game
	game = new Game(players)

	// Inform them the game has begun
	data = []
	players.forEach(function (p) {
		data.push({ id: p.id, name: p.name })
	})
	broadcast(players, MSG_MATCH_DONE, data)
}

// Tell all the current players waiting the current number of players in each ground
function informMatchingProgress() {
	var data = { waitingFor3: playersWaiting3.length, waitingFor4: playersWaiting4.length }
	broadcast(unite(playersWaiting3, playersWaiting4), MSG_MATCH_PROGRESS, data)
}

// Treat each client message
function onmessage(type, data) {
	if (this.game) {
		// Broadcast the message
		broadcast(this.game.players, name, data, this)
	} else if (type == MSG_MATCH) {
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
		broadcast(this.game.players, MSG_PLAYER_DISCONNECTED, this.id)
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
