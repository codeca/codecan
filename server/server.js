function saveLocalIp(ondone) {
	// Get the local ip for this machine and send to the server
	var windows = process.env.OS.match(/WINDOWS/i)
	require("child_process").exec(windows ? "ipconfig" : "ifconfig", function (error, stdout, stderr) {
		var ips
		if (error)
			throw new Error("Error")
		
		// Get all ips
		ips = stdout.toString().match(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g)
		if (!ips)
			throw new Error("Ip not found")
		
		// Send to server
		console.log("Saving your local ip ("+ips[0]+")...")
		require("http").get({
			hostname: "sitegui.com.br",
			path: "/codecan/setIp.php?ip="+ips[0],
			agent: false}, function (res) {
				if (res.statusCode != 200)
					throw new Error("Error in the request")
		}).once("close", ondone)
	})
}

saveLocalIp(start)

function start() {
	console.log("Done")
}
