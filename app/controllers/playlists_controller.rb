class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show destroy]

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist_sounds = @playlist.playlist_sounds
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      redirect_to playlists_path, notice: "Playlist created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @playlist.destroy
      redirect_to playlists_path, notice: "Playlist deleted"
    else
      redirect_to playlists_path, notice: "Playlist could not be deleted"
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
