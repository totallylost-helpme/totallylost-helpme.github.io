// Add a visible element to the DOM
const div = document.createElement('div');
div.id = 'xss-poc';
div.textContent = 'XSS via CORS successful!';
document.body.appendChild(div);

// Log a message to the console
console.log('XSS via CORS successful!');
