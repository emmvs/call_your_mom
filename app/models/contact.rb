class Contact < ApplicationRecord
  belongs_to :user
  has_many :interactions, dependent: :destroy

  validates :name, :user_id, :phone_number, :relationship, :address, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Must be a valid email address 📪" }
  validates :relationship, inclusion: { in: %w(friend family colleague), message: "%{value.capitalize} is not a valid relationship 🕺" }

  def full_contact_info
    "Name: #{name}, Email: #{email}, Phone: #{phone_number}, Address: #{address}"
  end
end
