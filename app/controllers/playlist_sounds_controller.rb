class PlaylistSoundsController < ApplicationController
  def create
    @playlist_sound = PlaylistSound.new(playlist_sound_params)
    if @playlist_sound.save
      redirect_to sounds_path, notice: "#{@playlist_sound.sound.title} added to #{@playlist_sound.playlist.title}"
    end
  end

  def destroy

  end

  private

  def playlist_sound_params
    params.require(:playlist_sound).permit(:playlist_id, :sound_id)
  end
end
