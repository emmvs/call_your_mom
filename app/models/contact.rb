class Contact < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :name, :relationship,  presence: true
  validates :name, :relationship, :email, :phone_number, :address, :social_media_handle, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Must be a valid email address 📪' }
  validates :relationship, inclusion: { in: %w[friend family colleague], message: "%{value} is not a valid relationship" }
end
