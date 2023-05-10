class PlaylistSoundsController < ApplicationController
  def create
    @playlist_sound = PlaylistSound.new(playlist_sound_params)
    if @playlist_sound.save
      redirect_to sounds_path, notice: "#{@playlist_sound.sound.title} added to #{@playlist_sound.playlist.title}"
    end
  end

  def destroy
    return unless @playlist_sound.user == current_user

    @playlist_sound = PlaylistSound.find(params[:id])
    sound = @playlist_sound.sound.title
    playlist = @playlist_sound.playlist
    if @playlist_sound.destroy
      redirect_to playlist_path(playlist), notice: "#{sound} removed from #{playlist.title}"
    else
      redirect_to playlist_path(playlist), notice: "#{sound} could not be removed from #{playlist.title}"
    end
  end

  private

  def playlist_sound_params
    params.require(:playlist_sound).permit(:playlist_id, :sound_id)
  end
end
