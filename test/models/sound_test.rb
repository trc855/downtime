require "test_helper"

class SoundTest < ActiveSupport::TestCase
  User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")

  test "should not save sound without user or audio file" do
    sound = Sound.new
    assert_not sound.save, "Saved the sound without a user or audio file"
  end

  test "should not save sound without audio file" do
    sound = Sound.new(user_id: 1)
    assert_not sound.save, "Saved the sound without an audio file"
  end

  test "should not save sound without user" do
    sound = Sound.new
    sound.audio.attach(io: File.open(Rails.root.join("test", "fixtures", "files", "test_audio.mp3")), filename: "test_audio.mp3", content_type: "audio/mp3")
    assert_not sound.save, "Saved the sound without a user"
  end

  test "should save sound with user and audio file" do
    sound = Sound.new(user_id: 1)
    sound.audio.attach(io: File.open(Rails.root.join("test", "fixtures", "files", "test_audio.mp3")), filename: "test_audio.mp3", content_type: "audio/mp3")
    assert sound.save, "Could not save the sound with a user and audio file. Errors: #{sound.errors.full_messages.to_sentence}"
  end
end

# NOTE: validating that I can add a sound, and that other users can’t see it, or that User A can’t delete user B’s sounds would be a great check to have in place.
