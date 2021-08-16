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
      site.style.display = '';
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
