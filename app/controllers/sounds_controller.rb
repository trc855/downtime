class SoundsController < ApplicationController
  before_action :set_sound, only: [:destroy]

  def index
    @sounds = Sound.all

    @markers = @sounds.geocoded.map do |sound|
      {
        lat: sound.latitude,
        lng: sound.longitude,
        sound_window_html: render_to_string(partial: "sound_window", locals: { sound: sound })
      }
    end
  end

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    @sound.user = current_user
    @sound.audio.attach(params[:sound][:audio])

    if @sound.save
      redirect_to sounds_path, notice: "Sound added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @sound.destroy
      redirect_to sounds_path, notice: "Sound deleted"
    else
      redirect_to sounds_path, notice: "Sound not deleted"
    end
  end

  private

  def sound_params
    params.require(:sound).permit(:title, :location, :audio)
  end

  def set_sound
    @sound = Sound.find(params[:id])
  end
end
