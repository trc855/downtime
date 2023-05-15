require "test_helper"

class PlaylistTest < ActiveSupport::TestCase
  User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")

  test "should not save without a valid user" do
    playlist = Playlist.new(title: "test playlist")
    assert_not playlist.save, "save without valid user"
  end

  test "should not save playlist without title" do
    playlist = Playlist.new(user_id: 1)
    assert_not playlist.save, "saved the playlist with no title"
  end

  test "should save with valid user and title" do
    playlist = Playlist.new(user_id: 1, title: "test playlist")
    assert playlist.save
  end
end
