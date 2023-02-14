class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_sounds, dependent: :destroy
  has_many :sounds, through: :playlist_sounds

  validates :title, presence: true
  validates :user, presence: true
end
