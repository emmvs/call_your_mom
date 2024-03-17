class Contact < ApplicationRecord
  RELATIONSHIP_TYPES = %w[friend family colleague]

  belongs_to :user
  has_many :interactions, dependent: :destroy

  validates :name, :user_id, :phone_number, :relationship, :address, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Must be a valid email address 📪" }
  validates :relationship, inclusion: { in: RELATIONSHIP_TYPES, message: "%{value.capitalize} is not a valid relationship 🕺" }
end
