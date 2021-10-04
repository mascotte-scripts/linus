let Modules = [
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

function loadPage(href){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET", href, false);
    xmlhttp.send();
    return xmlhttp.responseText;
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