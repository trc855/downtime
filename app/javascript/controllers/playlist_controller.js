import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["audiotag", "playbutton"]



  connect() {
    console.log("Hello from playlist controller!")

    // console.log(this.audiotagTarget.children[0])

    this.audioContext = null
    this.track = null
    this.audiotagTarget.children[0].addEventListener("canplay", this.createAudioContext.bind(this))
  }

  createAudioContext() {
    if(!this.audioContext){
      this.AudioContext = window.AudioContext || window.webkitAudioContext;
      this.audioContext = new AudioContext();

      this.audioElement = this.audiotagTarget.children[0];
      this.track = this.audioContext.createMediaElementSource(this.audioElement);
      this.track.connect(this.audioContext.destination);
    }
  }

  play() {
    console.log("play")

    if (this.audioContext.state === "suspended") {
      this.audioContext.resume();
    }

    const playButton = this.playbuttonTarget

    // Play or pause track depending on state
    if (playButton.dataset.playing === "false") {
      this.audioElement.play();
      playButton.dataset.playing = "true";
    } else if (playButton.dataset.playing === "true") {
      this.audioElement.pause();
      playButton.dataset.playing = "false";
    }

  }
}
