window.copyToClipboard = function(event) {

  var str = event.target.textContent;
  str = str.replace(/\s+/g,"");
  function listener(e) {
    e.clipboardData.setData("text/html", str);
    e.clipboardData.setData("text/plain",str);
    e.preventDefault();
  }
  document.addEventListener("copy", listener);
  document.execCommand("copy");
  document.removeEventListener("copy", listener);
}

document.addEventListener('turbolinks:load', function() {
	var campos_rep_legal = document.getElementsByClassName('disably');
	var lista = document.getElementById("ListaClientes");
	var boton_submit = document.getElementById("submitRepLegales");
	lista.onchange = function() {
		for(var i = 0, elemento; elemento = campos_rep_legal[i++];){
			if (elemento.type === "text"){
				elemento.value = "";
			}
			elemento.setAttribute("disabled", "true");	
		}	
	}
	boton_submit.onclick = function() {
		for(var i = 0, elemento; elemento = campos_rep_legal[i++];){
			elemento.removeAttribute("disabled");
		}	

	}
}); 
