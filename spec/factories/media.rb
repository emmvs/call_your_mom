FactoryBot.define do
  factory :medium do
    association :user
    name { Medium::MEDIA_TYPES.sample }
  end
end
