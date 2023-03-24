class SoundsController < ApplicationController
  before_action :set_sound, only: %i[show destroy]

  def index
    @sounds = Sound.all
    @playlists = current_user.playlists
    @playlist_sound = PlaylistSound.new

    @markers = @sounds.geocoded.map do |sound|
      {
        lat: sound.latitude,
        lng: sound.longitude,
        sound_window_html: render_to_string(partial: "sound_window", locals: { sound: sound })
      }
    end
  end

  def show
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
      redirect_to request.original_url =~ /sounds\/\d/ ? root_path : request.original_url, notice: "Sound deleted"
    else
      redirect_to request.original_url, notice: "Sound not deleted"
    end
  end

  def user_sounds
    @sounds = current_user.sounds
  end

  private

  def sound_params
    params.require(:sound).permit(:title, :location, :latitude, :longitude, :audio)
  end

  def set_sound
    @sound = Sound.find(params[:id])
  end
end
