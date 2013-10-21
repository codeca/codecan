// Simple echo server

require("./setIp.js")
var Player = require("./Player.js")

// Create the server and start listening
require("net").createServer(function (conn) {
    var p = new Player(conn)
    console.log("New connection")
    p.on("close", function () {
        console.log("Connection closed")
    })
    p.on("message", function (type, data) {
        console.log("Received", type, data)
        p.sendMessage(type, data)
    })
}).listen(8001)
