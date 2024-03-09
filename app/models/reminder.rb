class Reminder < ApplicationRecord
  belongs_to :reminderable, polymorphic: true
  belongs_to :user
end
