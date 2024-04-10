FactoryBot.define do
  factory :interaction do
    interaction_date { Time.current }
    association :user
    association :contact
    association :medium
    created_at { Time.current }
    updated_at { Time.current }
  end
end
