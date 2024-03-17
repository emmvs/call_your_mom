class Friendship < ApplicationRecord
  enum status: { requested: 0, accepted: 1, declined: 2 }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, uniqueness: { scope: :friend, message: "Friendship already exists 👯" }
end
