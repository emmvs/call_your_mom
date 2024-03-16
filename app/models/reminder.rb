# frozen_string_literal: true

class Reminder < ApplicationRecord
  FREQUENCY_UNITS = ['days', 'weeks', 'months'].freeze

  belongs_to :reminderable, polymorphic: true
  belongs_to :user
end
