var Player = require("./Player.js")

// Represent a game room

// Create a new game with the given players
function Game(players) {
	var i, j, temp, data, that

	// Shuffle and save the players
	for (i = players.length - 1; i > 0; i--) {
		j = Math.floor(Math.random() * (i + 1))
		temp = players[i]
		players[i] = players[j]
		players[j] = temp
	}
	this.players = players

	// Inform them the game has begun
	that = this
	data = [[], []]
	players.forEach(function (p) {
		p.game = that
		data[0].push(p.id)
		data[1].push(p.name)
	})
	Player.broadcast(players, "matchFound", data)
}

module.exports = Game
