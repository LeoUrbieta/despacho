window.copyToClipboard = function(event) {

  var str = event.target.textContent;
  str = str.replace(/\s+/g,"");
  var dos_puntos = str.indexOf(':');
  var contenido = str.substring(dos_puntos+1); 
  function listener(e) {
    e.clipboardData.setData("text/html", contenido);
    e.clipboardData.setData("text/plain", contenido);
    e.preventDefault();
  }
  document.addEventListener("copy", listener);
  document.execCommand("copy");
  document.removeEventListener("copy", listener);
}

