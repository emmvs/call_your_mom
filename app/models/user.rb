class User < ApplicationRecord
  GITHUB_USERNAME_PATTERN = /\A(?!\.)(?!_)[a-z0-9_\.]+(?<!\.)(?<!_)\z/
  PERMITTED_PARAMS = [
    :username, :email, :first_name, :middle_name, :last_name, :nickname, :emoji,
    { user_setting_attributes: %i[preferred_language time_zone] }
  ].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_setting, dependent: :destroy
  accepts_nested_attributes_for :user_setting

  has_many :contacts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :media, dependent: :destroy
  has_many :reminders, dependent: :destroy

  validates :username, uniqueness: true, format: {
    with: GITHUB_USERNAME_PATTERN,
    message: "Can only contain lowercase letters, numbers, underscores, periods, & cannot begin nor end with a period or underscore 🌈" 
  }
  validates :first_name, :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Must be a valid email address 📪' }
end
