class Contact < ApplicationRecord
  DISPLAY_ATTRIBUTES = %w[name email phone_number address relationship social_media_handle].freeze
  RELATIONSHIP_TYPES = %w[friend family colleague enemy].freeze

  belongs_to :user
  has_many :interactions, dependent: :destroy

  validates :name, :relationship, presence: true
  validates :relationship, inclusion: {
    in: RELATIONSHIP_TYPES, message: "%<value>s is not a valid relationship"
  }
end
