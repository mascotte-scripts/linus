async function post(url, data) {
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    })
  }
  
  window.addEventListener('load', () => {
    const site = document.getElementById('site-container')
  
    site.style.display = 'none';
    
  })
  
  window.addEventListener('message', event => {
    let item = event.data;
  
    if (item.type === 'ui') {
      const site = document.getElementById('site-container')
      document.getElementById('char-slot-1-name').innerHTML="Lorem Ipsum";
      
      if (item.status == true) {
        site.style.display = 'block';
      } else {
        site.style.display = 'none';
      }
    }
  })


  function CharSlotSelection(module, charid) {
    if (charid == 1) {
      console.log('Char id is 1')
      activecharid = 'char1'
    } else if (charid == 2) {
      console.log('char id is 2')
      activecharid = 'char2'
    } else if (charid == 3) {
      activecharid == "char3"
    } else if (charid == 4) {
      activecharid == "char4"
    }


    var x = document.getElementById(module);
    if (x.style.display === "none") {
      x.style.display = "block";
    } else {
      x.style.display = "none";
    }
  }

  function CreateCharacterData() {
    const CharacterData = [];
        CharacterData[0] = document.getElementById('creation-input-fname').value;
        CharacterData[1] = document.getElementById('creation-input-lname').value;
        CharacterData[2] = document.getElementById('creation-input-gender').value;
        CharacterData[3] = document.getElementById('creation-input-nation').value;
        CharacterData[4] = document.getElementById('creation-input-date').value;
        CharacterData[5] = activecharid;
            post('https://linus/SetCharacterData', CharacterData);
  }