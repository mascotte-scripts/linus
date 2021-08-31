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
      if (item.Char1InfoFName) { 
        var nametest = item.Char1InfoFName+' '+item.Char1InfoLName;
      document.getElementById('char-slot-1-name').innerHTML=nametest;
      }
      if (item.Char2InfoFName) { 
        var nametest2 = item.Char2InfoFName+' '+item.Char2InfoLName;
      document.getElementById('char-slot-2-name').innerHTML=nametest2;
      }
      if (item.status == true) {
        site.style.display = 'block';
      } else {
        site.style.display = 'none';
      }
    }
  })

  const charexists = false
  activecharid = 'char'

  function SetCharIdToPlayer(charid) {
    if (charid == 1) {
      console.log('Char id is 1')
      activecharid = 'char1'
    } else if (charid == 2) {
      console.log('char id is 2')
      activecharid = 'char2'
    } else if (charid == 3) {
      console.log('char id is 3')
      activecharid == "char3"
    } else if (charid == 4) {
      console.log('char id is 4')
      activecharid == "char4";
    }
  }

  function ToggleUiItemDisplay1(module) {

    const charslot = document.getElementById('char-slot-1-name').innerHTML;
    console.log(charslot)

    if (charslot == "Slot Empty") { 
      var x = document.getElementById(module);
      if (x.style.display === "block") {
        x.style.display = "none";
      } else {
        x.style.display = "block";
      } 
  } else { 
    var loadcharbox = document.getElementById('loadchar-form');
      console.log('do something')
     LoadCharacterDataOnNUI(1)
      if (loadcharbox.style.display === "block") {
        loadcharbox.style.display = "none";
      } else {
        loadcharbox.style.display = "block";
      } 
    }
  }

  function ToggleUiItemDisplay2(module) {

    const charslot = document.getElementById('char-slot-2-name').innerHTML;
    console.log(charslot)

    if (charslot == "Slot Empty") { 
      var x = document.getElementById(module);
      if (x.style.display === "block") {
        x.style.display = "none";
      } else {
        x.style.display = "block";
      } 
  } else { 
    LoadCharacterDataOnNUI(2)
    var loadcharbox = document.getElementById('loadchar-form');
      console.log('do something')
      if (loadcharbox.style.display === "block") {
    
        loadcharbox.style.display = "none";
      } else {
        loadcharbox.style.display = "block";
      } 
    }
  }

  function ToggleUiItemDisplay3(module) {

    const charslot = document.getElementById('char-slot-3-name').innerHTML;
    console.log(charslot)

    if (charslot == "Slot Empty") { 
      var x = document.getElementById(module);
      if (x.style.display === "block") {
        x.style.display = "none";
      } else {
        x.style.display = "block";
      } 
  } else { 
    var loadcharbox = document.getElementById('loadchar-form');
      console.log('do something')
      if (loadcharbox.style.display === "block") {
        loadcharbox.style.display = "none";
      } else {
        loadcharbox.style.display = "block";
      } 
    }
  }

  function ToggleUiItemDisplay4(module) {

    const charslot = document.getElementById('char-slot-4-name').innerHTML;
    console.log(charslot)

    if (charslot == "Slot Empty") { 
      var x = document.getElementById(module);
      if (x.style.display === "block") {
        x.style.display = "none";
      } else {
        x.style.display = "block";
      } 
  } else { 
    var loadcharbox = document.getElementById('loadchar-form');
      console.log('do something')
      if (loadcharbox.style.display === "block") {
        loadcharbox.style.display = "none";
      } else {
        loadcharbox.style.display = "block";
      } 
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

  function LoadCharacterIntoGame(bool) {
    if (bool == true) {
      post('https://linus/LoadCharacterData', activecharid);
    } else {
      console.log('Something Went Wrong..')
    }
  }
  
  function LoadCharacterDataOnNUI(charid) {
    if (charid == 1) { 

    var charslotnumber = "I"
    var charslotnumberHTML = '<h1 class="creation-form-title">Character '+charslotnumber+'</h1>';
      document.getElementById('char-slot-1-data-char').innerHTML=charslotnumberHTML;

    var loadedcharname ="Bob Dole";
    var charnameHTML = '<h3 class="creation-form-title">'+loadedcharname+'</h3>';
      document.getElementById('char-slot-1-data-name').innerHTML=charnameHTML;

    var loadedcharjob ="Police Officer";
    var charjobHTML = '<h3 class="creation-form-title">'+loadedcharjob+'</h3>';
      document.getElementById('char-slot-1-data-job').innerHTML=charjobHTML;

    var loadedcharbank ="$0.00";
    var charbankHTML = '<h3 class="creation-form-title">'+loadedcharbank+'</h3>';
      document.getElementById('char-slot-1-data-cash').innerHTML=charbankHTML;

      var loadedcharactive ="Last Active: 5 days";
      var charlastactiveHTML = '<h3 class="creation-form-title creation-form-title d-flex justify-content-center mt-2">'+loadedcharactive+'</h3>';
        document.getElementById('char-slot-1-data-lastactive').innerHTML=charlastactiveHTML;
        
     
  } else { 
     if (charid == 2) {

      var charslotnumber = "II"
      var charslotnumberHTML = '<h1 class="creation-form-title">Character '+charslotnumber+'</h1>';
        document.getElementById('char-slot-1-data-char').innerHTML=charslotnumberHTML;
  
      var loadedcharname ="Rob Dole";
      var charnameHTML = '<h3 class="creation-form-title">'+loadedcharname+'</h3>';
        document.getElementById('char-slot-1-data-name').innerHTML=charnameHTML;
  
      var loadedcharjob ="Medic";
      var charjobHTML = '<h3 class="creation-form-title">'+loadedcharjob+'</h3>';
        document.getElementById('char-slot-1-data-job').innerHTML=charjobHTML;
  
      var loadedcharbank ="$10.00";
      var charbankHTML = '<h3 class="creation-form-title">'+loadedcharbank+'</h3>';
        document.getElementById('char-slot-1-data-cash').innerHTML=charbankHTML;
  
        var loadedcharactive ="Last Active: 15 days";
        var charlastactiveHTML = '<h3 class="creation-form-title creation-form-title d-flex justify-content-center mt-2">'+loadedcharactive+'</h3>';
          document.getElementById('char-slot-1-data-lastactive').innerHTML=charlastactiveHTML;

      }
    }
  }