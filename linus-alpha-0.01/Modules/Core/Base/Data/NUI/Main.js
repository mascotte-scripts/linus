window.addEventListener('message', event => {
    let item = event.data;
    if (item.type === 'ui') {
      document.getElementById("NuiModuleBase").innerHTML=loadPage('/Modules/Core/Base/Data/NUI/Main.html');
      LoadModuleCSS('/Modules/Core/Base/Data/NUI/Main.css');
      // NUI data wont load unless we use a timeout to wait for the HTML to load
  setTimeout(function(){  const site = document.getElementById('site-container')
  if (item.CharNumber) { 
    var CharNumber = item.CharNumber;
    var CharName = item.CharName+' '+item.CharLastName;
  document.getElementById('char-slot-'+CharNumber+'-name').innerText=CharName;
  }
  if (item.status == true) {
    site.style.display = 'block';
  } else {
    site.style.display = 'none';
  }},5000) // Timeout Ends Here
    }
})

  let SetCharIdToPlayer = charid => {
  activecharid = charid
  return activecharid
  }

  ToggleUiItemDisplay = (module, characterslot, nuislot) => {
    let charslot = document.getElementById(characterslot).innerText;
      if (charslot == "Slot Empty") { 
        let x = document.getElementById(module);
        if (x.style.display === "block") {
          x.style.display = "none";
        } else {
          x.style.display = "block";
        } 
    } else { 
      let loadcharbox = document.getElementById('loadchar-form');
      LoadCharacterDataOnNUI(nuislot)
        if (loadcharbox.style.display === "block") {
          loadcharbox.style.display = "none";
        } else {
          loadcharbox.style.display = "block";
        } 
    }
  }

  CreateCharacterData = () => {
    const CharacterData = [];
    CharacterData[0] = document.getElementById('creation-input-fname').value;
    CharacterData[1] = document.getElementById('creation-input-lname').value;
    CharacterData[2] = document.getElementById('creation-input-gender').value;
    CharacterData[3] = document.getElementById('creation-input-nation').value;
    CharacterData[4] = document.getElementById('creation-input-date').value;
    CharacterData[5] = activecharid;
      post('https://linus/SetCharacterData', CharacterData);
  }

  LoadCharacterIntoGame = bool => {
    if (bool == true) {
      post('https://linus/LoadCharacterData', activecharid);
    } else {
      console.log('Something Went Wrong..')
    }
  }
  
  LoadCharacterDataOnNUI = charid => {
    if (charid) { 
      var romannum = romanize(charid);
    var charslotnumber = romannum;
    var charslotnumberHTML = '<h1 class="creation-form-title">Character '+charslotnumber+'</h1>';
      document.getElementById('char-slot-1-data-char').innerText=charslotnumberHTML;

    var loadedcharname ="Bob Dole";
    var charnameHTML = '<h3 class="creation-form-title">'+loadedcharname+'</h3>';
      document.getElementById('char-slot-1-data-name').innerText=charnameHTML;

    var loadedcharjob ="Police Officer";
    var charjobHTML = '<h3 class="creation-form-title">'+loadedcharjob+'</h3>';
      document.getElementById('char-slot-1-data-job').innerText=charjobHTML;

    var loadedcharbank ="$0.00";
    var charbankHTML = '<h3 class="creation-form-title">'+loadedcharbank+'</h3>';
      document.getElementById('char-slot-1-data-cash').innerText=charbankHTML;
      var loadedcharactive ="Last Active: 5 days";
      var charlastactiveHTML = '<h3 class="creation-form-title creation-form-title d-flex justify-content-center mt-2">'+loadedcharactive+'</h3>';
        document.getElementById('char-slot-1-data-lastactive').innerText=charlastactiveHTML;             
  }
} 
