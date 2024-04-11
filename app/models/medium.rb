class Medium < ApplicationRecord
  MEDIA_TYPES = [
    'In Person', 'Phone Call', 'Text Message', 'Voice Message',
    'Social Media', 'Gaming', 'Email', 'Meme'
  ].freeze

  belongs_to :user
  has_many :interactions, dependent: :destroy

  validates :name, inclusion: { in: MEDIA_TYPES, message: "%{value.capitalize} is not a valid medium 🔮" }
  validates :name, presence: true
  validates :user_id, presence: true
end
