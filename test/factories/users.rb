FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "username_#{i}" }
    sequence(:email) { |i| "test_#{i}@gmail.com" }
    password { "123123" }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
  end
end
