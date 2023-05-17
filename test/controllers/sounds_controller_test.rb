require "test_helper"

class SoundsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user_a = User.create(email: "user_A@example.com", password: "password123", password_confirmation: "password123")
    @user_b = User.create(email: "user_B@example.com", password: "password123", password_confirmation: "password123")

    @sound_a = Sound.new(user_id: @user_a.id)
    @sound_a.audio.attach(io: File.open(Rails.root.join("test", "fixtures", "files", "test_audio.mp3")), filename: "test_audio.mp3", content_type: "audio/mp3")
    @sound_a.save
  end

  test "user A can delete user A's sounds" do
    sign_in @user_a

    delete :destroy, params: { id: @sound_a.id }

    assert_nil Sound.find_by(id: @sound_a.id), "Sound should have been deleted"
  end

  test "user B can not delete user A's sounds" do
    sign_in @user_b

    delete :destroy, params: { id: @sound_a.id }

    assert_not_nil Sound.find_by(id: @sound_a.id), "Sound should not have been deleted"
  end
end
