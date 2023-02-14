class Sound < ApplicationRecord
  belongs_to :user
  has_many :playlist_sounds, dependent: :destroy

  has_one_attached :audio, dependent: :destroy

  validates :audio, presence: true
  validates :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
