class User < ApplicationRecord
  GITHUB_USERNAME_PATTERN = /\A(?!\.)(?!_)[a-z0-9_\.]+(?<!\.)(?<!_)\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  validates :username, uniqueness: true, format: { with: GITHUB_USERNAME_VALIDATION, message: "Only allows lowercase letters 🙇🏼‍♀️" }
end
