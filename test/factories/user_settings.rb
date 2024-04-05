FactoryBot.define do
  factory :user_setting do
    preferred_language { 'en' }
    time_zone { 'Europe/Berlin' }
    association :user
  end
end
