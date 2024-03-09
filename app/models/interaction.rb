class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :contact
  belongs_to :medium
end
