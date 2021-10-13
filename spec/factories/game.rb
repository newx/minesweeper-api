# Create a factory for a game
FactoryBot.define do
  factory :game do
    association :user, factory: :user

    rows { 10 }
    cols { 10 }
    mines { 10 }
  end
end