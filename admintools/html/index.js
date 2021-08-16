function post(url, data) {
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

    if (item.status == true) {
      site.style.display = 'block';
    } else {
      site.style.display = 'none';
    }
  }
})

window.addEventListener('keyup', event => {
  if (event.keyCode === 27) {
    post('https://admintools/exit', {});
  }
})

/*
const close = document.getElementById('close')

close.addEventListener('click', () => {
  post('https://admintools/exit', {})
})

const submit = document.getElementById('submit')

submit.addEventListener('click', () => {
  const input = document.getElementById('input')
  let value = input.val()

  if (value.length >= 100) {
    // we probably want a more verbose error
    post('https://admintools/error', {error: 'Input was greater than 100'});
    return;
  } else if (!value) {
    post('https://admintools/error', {error: 'Input field was empty'});
    return;
  }

  post('http://admintools/main', {text: value});
})
*/


var draggableElements = document.getElementsByClassName("draggable");

// Make the DIV element draggable:
for(var i = 0; i < draggableElements.length; i++){
  dragElement(draggableElements[i]);
}

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "-header")) {
    // if present, the header is where you move the DIV from:
    document.getElementById(elmnt.id + "-header").onmousedown = dragMouseDown;
  } else {
    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
  }
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
