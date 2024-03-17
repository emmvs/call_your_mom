class UserSetting < ApplicationRecord
  SUPPORTED_LOCALES = ['en', 'es', 'de', 'sv', 'fr', 'mt', 'ar'].freeze

  belongs_to :user
end
