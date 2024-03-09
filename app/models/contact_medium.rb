class ContactMedium < ApplicationRecord
  belongs_to :contact
  belongs_to :medium
end
