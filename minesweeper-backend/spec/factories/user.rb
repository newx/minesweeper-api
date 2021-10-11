# Create a factory for a user
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end