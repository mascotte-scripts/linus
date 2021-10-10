window.addEventListener('message', event => {
  let item = event.data;
    if (item.type === 'adminui') {
      document.getElementById("NuiModuleBase").innerHTML=loadPage('/Modules/Core/AdminTools/Data/NUI/Main.html');
      LoadModuleCSS('/Modules/Core/AdminTools/Data/NUI/Main.css');
        setTimeout(function(){ const adminsite = document.getElementById('admin-site-container')
        if (item.status == true) {
          adminsite.style.display = 'block';
        } else {
          adminsite.style.display = 'none';
        }}, 3000);      
    }
})

window.addEventListener('keyup', event => {
  if (event.keyCode === 27) {
    post('https://linus/exit', {});
  }
})

  document.getElementById("admin-execute-button").addEventListener("click", function() {
    var getinputdata = document.getElementById('command-execute-nui').value
  var select = document.getElementById('inputGroupSelect01');
var value = select.options[select.selectedIndex].value; // en
    if (value == 1) { 
      post('https://linus/AdminTools:ban', getinputdata);
    } else
    if (value == 2) { 
      post('https://linus/AdminTools:kick', getinputdata);
    } else
    if (value == 6) { 
      post('https://linus/AdminTools:spawnvehicle', getinputdata); 
    }
  });