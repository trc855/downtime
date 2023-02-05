class Sound < ApplicationRecord
  belongs_to :user

  has_one_attached :audio, dependent: :destroy
end
