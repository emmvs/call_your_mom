class Interaction < ApplicationRecord
  validates :interaction_date, presence: true
  validates :contact_id, presence: true
  validates :medium_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :contact
  belongs_to :medium

  has_many :notes, dependent: :destroy
  accepts_nested_attributes_for :notes, allow_destroy: true
end
