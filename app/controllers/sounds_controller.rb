class SoundsController < ApplicationController
  def index
    @sounds = Sound.all
  end

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    @sound.user = current_user

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
    params.require(:sound).permit(:title, :lat, :long)
  end
end
