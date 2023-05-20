require "test_helper"

class PlaylistsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user_a = User.create(email: "user_A@example.com", password: "password123", password_confirmation: "password123")
    @user_b = User.create(email: "user_B@example.com", password: "password123", password_confirmation: "password123")

    @playlist_a = Playlist.create(user_id: @user_a.id, title: "Playlist A")
  end

  test "user A can delete user A's playlists" do
    sign_in @user_a

    delete :destroy, params: { id: @playlist_a.id }

    assert_nil Playlist.find_by(id: @playlist_a.id), "Playlist should have been deleted"
  end

  test "user B can not delete user A's playlists" do
    sign_in @user_b

    delete :destroy, params: { id: @playlist_a.id }

    assert_not_nil Playlist.find_by(id: @playlist_a.id), "Playlist should not have been deleted"
  end
end
