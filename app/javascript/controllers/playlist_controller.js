import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["audiotag", "playbutton"]

  connect() {
    console.log("Hello from playlist controller!")

    // console.log(this.audiotagTarget.children[0])
  }

  play() {
    console.log("play")

    const AudioContext = window.AudioContext || window.webkitAudioContext;
    const audioContext = new AudioContext();

    const audioElement = this.audiotagTarget.children[0]
    const track = audioContext.createMediaElementSource(audioElement);

    track.connect(audioContext.destination);

    if (audioContext.state === "suspended") {
      audioContext.resume();
    }

    const playButton = this.playbuttonTarget

    // Play or pause track depending on state
    if (playButton.dataset.playing === "false") {
      audioElement.play();
      playButton.dataset.playing = "true";
    } else if (playButton.dataset.playing === "true") {
      audioElement.pause();
      playButton.dataset.playing = "false";
    }

  }
}
