window.copyToClipboard = function(event) {

  var str = event.target.innerHTML;
  str = str.replace(/\s+/g,""); 
  function listener(e) {
    e.clipboardData.setData("text/html", str);
    e.clipboardData.setData("text/plain", str);
    e.preventDefault();
  }
  document.addEventListener("copy", listener);
  document.execCommand("copy");
  document.removeEventListener("copy", listener);
}

