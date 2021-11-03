const cssSheet = '/Modules/Core/Base/Data/NUI/Main.css';
const htmlPage = '/Modules/Core/Base/Data/NUI/Main.html';
const moduleName = "NuiModuleBase";

window.addEventListener('message', event => {
  let item = event.data;
  eventData = item;
  if (item.type === 'ui') {
    loadNuiPage(item);
  }
})

async function loadNuiPage(item) {
  let promise = new Promise(function(resolve, reject){
    resolve(loadPage(htmlPage));
  });
  document.getElementById(moduleName).innerHTML = await promise;
  promise.then(() => {
    loadNuiCSS(item);
  });
}

async function loadNuiCSS(item) {
  let promise = new Promise(function(resolve, reject){
    resolve(LoadModuleCSS(cssSheet));
  });
  promise.then(() => {
    loadNuiCharacterData(item);
  }
  );
}

function loadNuiCharacterData(item) {
    const site = document.getElementById('site-container');
    if (item.status == true) {
      site.style.display = 'block';
  } else {
      site.style.display = 'none';
  }
  setTimeout(function() {
    if (item.CharNumber) {
        let CharNumber = item.CharNumber;
        let CharName = `${item.CharName} ${item.CharLastName}`;    
        document.getElementById(`char-slot-${CharNumber}-name`).innerText = CharName;
    }
  }, 1000);
    resourcename = item.resourcename;
  }

let SetCharIdToPlayer = charid => {
  activecharid = charid;
  return activecharid;
}

let SetCharIdToPlayer = charid => {
  activecharid = charid;
  return activecharid;
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
  post(`https://${resourcename}/Base/SetCharacterData`, CharacterData);
}

let LoadCharacterIntoGame = bool => {
  if (bool == true) {
      post(`https://${resourcename}/Base/LoadCharacterData`, activecharid);
  } else {
      console.log('Something Went Wrong..')
  }
}

let LoadCharacterDataOnNUI = charid => {
  let romannum = romanize(charid);
  document.getElementById('char-slot-data-char').innerText = `Character ${romannum}`;
  let loadedcharname = "Bob Dole";
  document.getElementById('char-slot-data-name').innerText = loadedcharname;
  let loadedcharjob = "Police Officer";
  document.getElementById('char-slot-data-job-text').innerText = loadedcharjob;
  let loadedcharbank = "$0.00";
  document.getElementById('char-slot-data-balance').innerText = loadedcharbank;
  let loadedcharactive = "Last Active: 5 days";
  document.getElementById('char-slot-data-lastactive').innerText = loadedcharactive;
}
