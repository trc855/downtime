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

  test "title should be unique wrt user" do
    Playlist.create(user_id: 1, title: "test playlist")

    playlist = Playlist.new(user_id: 1, title: "test playlist")
    assert_not playlist.save, "saved playlist with duplicate title"
  end

  test "title can be non unique globally" do
    Playlist.create(user_id: 1, title: "test playlist")

    new_user = User.create(email: "test2@example.com", password: "password123", password_confirmation: "password123")
    playlist = Playlist.new(user_id: new_user.id, title: "test playlist")

    assert playlist.save, "could not save playlist with globally non unique title"
  end
end
