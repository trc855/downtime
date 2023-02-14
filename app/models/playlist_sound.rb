class PlaylistSound < ApplicationRecord
  belongs_to :sound
  belongs_to :playlist

  validates :sound, presence: true
  validates :playlist, presence: true
end
