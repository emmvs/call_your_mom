class Reminder < ApplicationRecord
  FREQUENCY_UNITS = ['day', 'week', 'month'].freeze

  belongs_to :reminderable, polymorphic: true
  belongs_to :user
end
