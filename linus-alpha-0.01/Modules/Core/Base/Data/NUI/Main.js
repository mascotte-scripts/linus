window.addEventListener('message', event => {
    let item = event.data;
    if (item.type === 'ui') {
      document.getElementById("NuiModuleBase").innerHTML=loadPage('/Modules/Core/Base/Data/NUI/Main.html');
      LoadModuleCSS('/Modules/Core/Base/Data/NUI/Main.css');
      // NUI data wont load unless we use a timeout to wait for the HTML to load  
      window.onload=waitForNUItoLoad(item);
    }
})

  function waitForNUItoLoad(item) {
    setTimeout(function () {
    const site = document.getElementById('site-container');
    if (item.CharNumber) {
      var CharNumber = item.CharNumber;
      var CharName = `${item.CharName} ${item.CharLastName}`;
      document.getElementById(`char-slot-${CharNumber}-name`).innerText = CharName;
    }
    if (item.status == true) {
      site.style.display = 'block';
    } else {
      site.style.display = 'none';
    }
  }, 1000);
}

  let SetCharIdToPlayer = charid => {
  activecharid = charid
  return activecharid
  }

  let ToggleUiItemDisplay = (module, characterslot, nuislot) => {
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

  let CreateCharacterData = () => {
    const CharacterData = {};
    CharacterData.firstname = document.getElementById('creation-input-fname').value;
    CharacterData.lastname = document.getElementById('creation-input-lname').value;
    CharacterData.gender = document.getElementById('creation-input-gender').value;
    CharacterData.nationality = document.getElementById('creation-input-nation').value;
    CharacterData.dob = document.getElementById('creation-input-date').value;
    CharacterData.charid = activecharid;
      post('https://linus/Base/SetCharacterData', CharacterData);
  }

  let LoadCharacterIntoGame = bool => {
    if (bool == true) {
      post('https://linus/Base/LoadCharacterData', activecharid);
    } else {
      console.log('Something Went Wrong..')
    }
  }
  
let LoadCharacterDataOnNUI = charid => { 
    let romannum = romanize(charid);
    let charslotnumber = romannum;
      document.getElementById('char-slot-data-char').innerText=`Character ${charslotnumber}`;
    let loadedcharname ="Bob Dole";
      document.getElementById('char-slot-data-name').innerText=loadedcharname;
    let loadedcharjob ="Police Officer";
      document.getElementById('char-slot-data-job-text').innerText=loadedcharjob;
    let loadedcharbank ="$0.00";
      document.getElementById('char-slot-data-balance').innerText=loadedcharbank;
    let loadedcharactive ="Last Active: 5 days";
      document.getElementById('char-slot-data-lastactive').innerText=loadedcharactive;             
} 