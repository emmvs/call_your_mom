class User < ApplicationRecord
  GITHUB_USERNAME_PATTERN = /\A(?!\.)(?!_)[a-z0-9_\.]+(?<!\.)(?<!_)\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :user_settings, dependent: :destroy
  has_many :media, dependent: :destroy
  has_many :reminders, dependent: :destroy

  validates :username, uniqueness: true, format: { with: GITHUB_USERNAME_PATTERN, message: "Can only contain lowercase letters, numbers, underscores, periods, & cannot begin nor end with a period or underscore 🌈" }

  validates :first_name, :last_name, presence: :true
end
