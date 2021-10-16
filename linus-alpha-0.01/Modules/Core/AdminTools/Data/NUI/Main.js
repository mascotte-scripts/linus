window.addEventListener('message', event => {
  let item = event.data;
    if (item.type === 'adminui') {
      document.getElementById("NuiModuleBase").innerHTML=loadPage('/Modules/Core/AdminTools/Data/NUI/Main.html');
      LoadModuleCSS('/Modules/Core/AdminTools/Data/NUI/Main.css');
      window.onload = nuiReady(item);
    }
})

let nuiReady = item => {
  setTimeout(function() {
  const adminsite = document.getElementById('admin-site-container')
        if (item.status == true) {
          adminsite.style.display = 'block';
        } else {
          adminsite.style.display = 'none';   
    }
    resourcename = item.resourcename;
  }, 1000);
}

window.addEventListener('keyup', event => {
  if (event.keyCode === 27) {
    post(`https://${resourcename}/admintools/exit`, {});
  }
})

let adminActionExecute = () => {
  var getinputdata = document.getElementById('command-execute-nui').value
  var select = document.getElementById('inputGroupSelect01');
  var value = select.options[select.selectedIndex].value; // en
    if (value == 1) { 
      post(`https://${resourcename}/admintools/ban`, getinputdata);
    } else
    if (value == 2) { 
      post(`https://${resourcename}/admintools/kick`, getinputdata);
    } 
    else 
    if (value == 3) {
      post(`https://${resourcename}/admintools/depositcash`, getinputdata);
    }
    else 
    if (value == 4) {
      post(`https://${resourcename}/admintools/removecash`, getinputdata);
    }
    else
    if (value == 6) { 
      post(`https://${resourcename}/admintools/spawnvehicle`, getinputdata); 
    }
}