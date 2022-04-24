import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="deshabilita-campos-rep-legales"
export default class extends Controller {
  static targets = [ "source" , "campo" , "form"]

  deshabilita() {
    this.campoTargets.forEach(function (item,index){
      if (item.type === "text"){
	item.value = "";
      }
      item.setAttribute("disabled", "true");	
    })
  }

  clickBotonSubmit(event) {
    event.preventDefault()
    this.campoTargets.forEach(function (item,index){
      item.removeAttribute("disabled"); 
    })
    this.formTarget.submit()
  }
} 
