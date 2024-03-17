class Reminder < ApplicationRecord
  FREQUENCY_UNITS = ['day', 'week', 'month'].freeze

  belongs_to :reminderable, polymorphic: true
  belongs_to :user

  validates :frequency_unit, inclusion: { in: FREQUENCY_UNITS, message: "%{value.capitalize} is not a valid frequency ☝🏻" }
end
