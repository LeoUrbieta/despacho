import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "source" ]
  copy() {
    var str = this.sourceTarget.textContent
    str = str.replace(/\s+/g,"");
    navigator.clipboard.writeText(str)
  }
}
