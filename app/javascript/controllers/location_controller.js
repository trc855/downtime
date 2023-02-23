import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    // console.log("Hello from location controller")
  }

  showLocInput() {
    this.inputTarget.classList.remove("d-none")
  }

  hideLocInput() {
    this.inputTarget.classList.add("d-none")
  }
}
