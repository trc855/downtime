class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_sounds

  validates :title, presence: true
  # validates :user, presence: true
end
