class Contact < ApplicationRecord
  RELATIONSHIP_TYPES = %i[friend family colleague enemy].freeze

  belongs_to :user
  has_many :interactions, dependent: :destroy

  validates :name, :relationship, :user_id, presence: true
  validates :relationship, inclusion: {
    in: RELATIONSHIP_TYPES.map(&:to_s), message: "%<value>s is not a valid relationship"
  }
end
