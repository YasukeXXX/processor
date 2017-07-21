FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
