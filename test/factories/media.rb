FactoryBot.define do
  factory :medium do
    sequence(:name) { |n| "Medium #{n}" }
    association :user
  end
end
