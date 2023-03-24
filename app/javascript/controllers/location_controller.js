import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};

export default class extends Controller {
  static targets = ["input", "lat", "long", "coords"];

  connect() {
    // console.log("Hello from location controller")
    // console.log(this.coordsTarget);
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
    // console.log("Your current position is:");
    // console.log(`Latitude : ${crd.latitude}`);
    // console.log(`Longitude: ${crd.longitude}`);
    // console.log(`More or less ${crd.accuracy} meters.`);
    // console.log(this.coordsTarget);
    this.setCoords(crd)
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  setCoords(crd) {
    console.log(crd);
    this.latTarget.value = crd.latitude
    this.longTarget.value = crd.longitude
    console.log(this.coordsTarget);
  }
}
