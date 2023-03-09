import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage";

export default class extends Controller {

  connect() {
    this.audio()
  }

  audio() {
    let record = document.getElementById("audio-record-button")
    let fileField = document.getElementById("sound_audio")

    let recording = false

    if(navigator.mediaDevices.getUserMedia) {
      const constraints = { audio: true }
      let chunks = []

      let onSuccess = function (stream) {
        const mediaRecorder = new MediaRecorder(stream)

        record.onclick = function (event) {
          console.log("Record button clicked")
          event.preventDefault
          if (recording) {
            mediaRecorder.stop()
            record.classList.remove("btn-danger")
            record.classList.add("btn-dark")
            record.style.padding = "6px 12px"
            record.innerHTML = "<i class='fa-solid fa-microphone'></i>"
          } else {
            mediaRecorder.start()
            record.classList.remove("btn-dark")
            record.classList.add("btn-danger")
            record.style.padding = "6px 10.5px"
            record.innerHTML = "<div class='boxContainer'><div class='box box1'></div><div class='box box2'></div><div class='box box3'></div><div class='box box4'></div><div class='box box5'></div></div>"
          }
          recording = !recording
        }

        mediaRecorder.onstop = function (event) {
          const audioType = "audio/ogg; codes=opus"
          const blob = new Blob(chunks, { type: audioType })
          chunks = []

          let file = new File([blob], "audio-recording.ogg", {
            type: audioType,
            lastModified: new Date().getTime()
          })
          let container = new DataTransfer();
          container.items.add(file)
          uploadFile(file)
          fileField.files = container.files
          // below is optional
          // fileField.dispatchEvent(new Event("change"))
        }

        mediaRecorder.ondataavailable = function (event) {
          chunks.push(event.data)
        }

      }
      let onError = function (err) {
        console.log("The following error occurred: " + err)
      }

      navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError)
    } else {
      console.log("getUserMedia not supported by your browser!")
    }
  }
}

const uploadFile = (file) => {
  const input = document.getElementById('sound_audio')
  const url = input.dataset.directUploadUrl

  const upload = new DirectUpload(file, url)

  upload.create((error, blob) => {
    if (error) {
      console.log(error)
    } else {
      const hiddenField = document.createElement("input")
      hiddenField.setAttribute("value", "hidden")
      hiddenField.setAttribute("value", blob.signed_id)
      hiddenField.name = input.name
      let soundForm = document.getElementById("sound-form")
      soundForm.appendChild(hiddenField)
    }
  })
}
