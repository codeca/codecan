// Simple broadcaster server

require("./setIp.js")
var Player = require("./Player.js")

// Store all players connected
var players = []

// Create the server and start listening
require("net").createServer(function (conn) {
    var p = new Player(conn)
    console.log("New connection")
    players.push(p)
    p.on("close", function () {
        console.log("Connection closed")
        players.splice(players.indexOf(p))
    })
    p.on("message", function (type, data) {
        console.log("Received", type, data)
        players.forEach(function (p2) {
            if (p2 != p)
                p2.sendMessage(type, data)
        })
    })
}).listen(8001)
