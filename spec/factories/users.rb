FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@ex.ample" }
    password 'password'
    password_confirmation 'password'
  end
end
