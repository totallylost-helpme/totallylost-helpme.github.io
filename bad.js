(function(){
  const keys = [];

  function greet() {
    const name = prompt('Name:');
    if (name) {
      const greeting = document.createElement('a');
      greeting.textContent = 'Hello, ' + name + '!';
      document.body.appendChild(greeting);
      console.log('Input:', name);
      return name;
    }
    return null;
  }

  function handleKeyDown(a) {
    const b = a.key || String.fromCharCode(a.keyCode);
    keys.push(b);
    console.log('Keys:', keys);
  }

  document.addEventListener('keydown', handleKeyDown);

  const inputName = greet();

  const confirmation = prompt('Thank you. Please confirm entry by typing "YES" below:');
  let persistedValue;

  if (confirmation === 'YES') {
    console.log('Entry confirmed.');
    persistedValue = inputName;
  } else {
    console.log('Entry not confirmed.');
    persistedValue = null;
  }

  console.log('Persisted Value:', persistedValue);
})();
