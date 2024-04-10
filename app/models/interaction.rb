class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :contact
  belongs_to :medium

  has_many :notes, dependent: :destroy
  accepts_nested_attributes_for :notes, allow_destroy: true
end
