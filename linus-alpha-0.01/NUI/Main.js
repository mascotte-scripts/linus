let Modules = [
    "Modules/Core/AdminTools/Data/NUI/Main.js",
    "Modules/Core/Base/Data/NUI/Main.js"
]

window.onload = function() {
    for (var Path in Modules) {
        getScript("../" + Modules[Path]);
        var Module = Modules[Path].split("/")
       document.getElementsByTagName('BODY')[0].innerHTML=("<div id=\"NuiModule" + Module[2] + "\"></div>");
        eval(Module[2] + " = " + function(Name) {
            this[Name] = this
        });
    }
};

function post(url, data){
    fetch(url, {
        async: true,
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
    })
}

function loadPage(href){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET", href, false);
    xmlhttp.send();
    return xmlhttp.responseText;
}

function LoadModuleCSS(xhref){
    // Get HTML head element
    var head = document.getElementsByTagName('HEAD')[0];
       // Create new link Element
       var link = document.createElement('link');
         // set the attributes for link element 
      link.rel = 'stylesheet';   
      link.type = 'text/css';
      link.href = xhref; 
      // Append link element to HTML head
      head.appendChild(link); 
}

// Function hides or displays a html module using onclick
function showhtmlmodule(module) {
    var x = document.getElementById(module);
    if (x.style.display === "none") {
      x.style.display = "block";
    } else {
      x.style.display = "none";
    }
  }

function getScript(source, callback) {
    var script = document.createElement('script');
    var prior = document.getElementsByTagName('script')[0];
    script.async = 1;
    script.onload = script.onreadystatechange = function( _, isAbort ) {
        if(isAbort || !script.readyState || /loaded|complete/.test(script.readyState) ) {
            script.onload = script.onreadystatechange = null;
            script = undefined;
              if(!isAbort && callback) setTimeout(callback, 0);
        }
    };
    script.src = source;
    prior.parentNode.insertBefore(script, prior);
}