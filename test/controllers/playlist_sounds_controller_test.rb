require "test_helper"

class PlaylistSoundsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user_a = User.create(email: "user_A@example.com", password: "password123", password_confirmation: "password123")
    @user_b = User.create(email: "user_B@example.com", password: "password123", password_confirmation: "password123")

    playlist_a = Playlist.create(user_id: @user_a.id, title: "Playlist A")

    sound_a = Sound.new(user_id: @user_a.id)
    sound_a.audio.attach(io: File.open(Rails.root.join("test", "fixtures", "files", "test_audio.mp3")), filename: "test_audio.mp3", content_type: "audio/mp3")
    sound_a.save

    sound_b = Sound.new(user_id: @user_b.id)
    sound_b.audio.attach(io: File.open(Rails.root.join("test", "fixtures", "files", "test_audio.mp3")), filename: "test_audio.mp3", content_type: "audio/mp3")
    sound_b.save

    @playlist_sound_a = PlaylistSound.create(playlist_id: playlist_a.id, sound_id: sound_a.id)
    @playlist_sound_b = PlaylistSound.create(playlist_id: playlist_a.id, sound_id: sound_b.id)
  end

  test "user A can delete user A's playlist's playlist_sounds" do
    sign_in @user_a

    delete :destroy, params: { id: @playlist_sound_a.id }
    delete :destroy, params: { id: @playlist_sound_b.id }

    assert_nil PlaylistSound.find_by(id: @playlist_sound_a.id), "Playlist_sound_a should have been deleted"
    assert_nil PlaylistSound.find_by(id: @playlist_sound_b.id), "Playlist_sound_b should have been deleted"
  end

  test "user B can not delete user A's playlist's playlist_sounds" do
    sign_in @user_b

    delete :destroy, params: { id: @playlist_sound_a.id }
    delete :destroy, params: { id: @playlist_sound_b.id }

    assert_not_nil PlaylistSound.find_by(id: @playlist_sound_a.id), "Playlist_sound_a should not have been deleted"
    assert_not_nil PlaylistSound.find_by(id: @playlist_sound_b.id), "Playlist_sound_b should not have been deleted"
  end
end
