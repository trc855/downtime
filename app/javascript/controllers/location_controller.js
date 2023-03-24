import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};

export default class extends Controller {
  static targets = ["input", "lat", "long"];

  connect() {
    // console.log("Hello from location controller")
  }

  showLocInput() {
    this.inputTarget.classList.remove("d-none")
  }

  hideLocInput() {
    this.inputTarget.classList.add("d-none")
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error, options);
  }

  success(pos) {
    const crd = pos.coords;
    this.setCoords(crd)
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  setCoords(crd) {
    this.latTarget.value = crd.latitude
    this.longTarget.value = crd.longitude
  }
}
