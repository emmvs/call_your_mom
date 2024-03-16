class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, uniqueness: { scope: :friend, message: "Friendship already exists 👯" }

  enum status: { requested: 0, accepted: 1, declined: 2 }
end
