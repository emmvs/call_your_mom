FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "username_#{i}"}
    sequence(:email) { |i| "test_#{i}@gmail.com"}
    password { "123123" }
  end
end
