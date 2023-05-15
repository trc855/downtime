class PlaylistSoundsController < ApplicationController
  before_action :set_playlist_sound, only: :destroy

  def create
    @playlist_sound = PlaylistSound.new(playlist_sound_params)
    if @playlist_sound.save
      redirect_to sounds_path, notice: "#{@playlist_sound.sound.title} added to #{@playlist_sound.playlist.title}"
    end
  end

  def destroy
    playlist = @playlist_sound.playlist
    sound = @playlist_sound.sound.title

    if @playlist_sound.playlist.user == current_user
      @playlist_sound.destroy
      redirect_to playlist_path(playlist), notice: "#{sound} removed from #{playlist.title} successfully."
    else
      redirect_to playlist_path(playlist), notice: "You do not have permission to remove #{sound} from #{playlist.title}."
    end
  end

  private

  def playlist_sound_params
    params.require(:playlist_sound).permit(:playlist_id, :sound_id)
  end

  def set_playlist_sound
    @playlist_sound = PlaylistSound.find(params[:id])
  end
end
