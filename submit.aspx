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
        // Example of simple fingerprinting JavaScript
        function getFingerprint() {
            var fingerprint = {};
            fingerprint.userAgent = navigator.userAgent;
            fingerprint.language = navigator.language;
            fingerprint.screenResolution = window.screen.width + "x" + window.screen.height;
            fingerprint.timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
            fingerprint.plugins = navigator.plugins.length;
            fingerprint.cpuClass = navigator.cpuClass || "unknown";
            fingerprint.hardwareConcurrency = navigator.hardwareConcurrency || "unknown";
            return fingerprint;
        }

        console.log(getFingerprint());
    </script>
</body>
</html>
<%
    }
%>
