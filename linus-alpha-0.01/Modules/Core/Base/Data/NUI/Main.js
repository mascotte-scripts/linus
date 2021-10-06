activecharid = 'char'

post = (url, data) => {
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    })
  }

  let obj =  document.getElementById("NuiModuleBase").innerHTML=loadPage('/Modules/Core/Base/Data/NUI/Main.html');

  load_home = () => {

      // Get HTML head element
      var head = document.getElementsByTagName('HEAD')[0];

         // Create new link Element
         var link = document.createElement('link');

           // set the attributes for link element 
        link.rel = 'stylesheet'; 
      
        link.type = 'text/css';
      
        link.href = '/Modules/Core/Base/Data/NUI/Main.css'; 
  
        // Append link element to HTML head
        head.appendChild(link); 
  }

  load_home();
  
  window.addEventListener('load', () => {
    const site = document.getElementById('NuiModuleBase')
    site.style.display = 'none'; 
  })

  
  window.addEventListener('message', event => {
    let item = event.data;
    if (item.type === 'ui') {
      const site = document.getElementById('site-container')
      if (item.Char1Name) { 
        var CharName = item.Char1Name+' '+item.Char1LastName;
      document.getElementById('char-slot-1-name').innerHTML=CharName;
      }
      if (item.Char2Name) { 
        var CharName = item.Char2Name+' '+item.Char2LastName;
      document.getElementById('char-slot-2-name').innerHTML=CharName;
      }
      if (item.Char3Name) { 
        var CharName = item.Char3Name+' '+item.Char3LastName;
      document.getElementById('char-slot-3-name').innerHTML=CharName;
      }
      if (item.Char4Name) { 
        var CharName = item.Char4Name+' '+item.Char4LastName;
      document.getElementById('char-slot-4-name').innerHTML=CharName;
      }     
      if (item.status == true) {
        site.style.display = 'block';
      } else {
        site.style.display = 'none';
      }
    }
  })

  let SetCharIdToPlayer = charid => {
    if (charid == 1) {
      activecharid = 1;
    } if (charid == 2) {
      activecharid = 2;
    } if (charid == 3) {
      activecharid = 3;
    } if (charid == 4) {
      activecharid = 4;
    }
  }

  ToggleUiItemDisplay = (module, characterslot, nuislot) => {
    let charslot = document.getElementById(characterslot).innerHTML;
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
      } else { 
        if (charid == 3) {
         var charslotnumber = "III"
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
         } else { 
          if (charid == 4) {
           var charslotnumber = "IV"
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
  }
} 