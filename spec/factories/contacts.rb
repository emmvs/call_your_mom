FactoryBot.define do
  factory :contact do
    sequence(:name) { |i| "Contact #{i}" }
    relationship { ['friend', 'family', 'colleague'].sample }
    sequence(:email) { |i| "name_#{i}@test.com" }
    sequence(:phone_number) { |i| "+982536562333#{i}" }
    sequence(:address) { |i| "Meanstreeet #{i}, Berlin" }
    sequence(:social_media_handle) { |i| "@emmvs_#{i}" }
    association :user
  end
end
