import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [ "modal", "overlay" ]

  connect() {
  }

  open() {
    this.modalTarget.classList.remove('d-none');
    this.overlayTarget.classList.add('overlay');
  }

  close() {
    this.modalTarget.classList.add('d-none');
    this.overlayTarget.classList.remove('overlay');
  }
}
