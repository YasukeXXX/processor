FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    account_activation { build :account_activation }

    trait :activated do
      after(:create) do |user|
        user.activate
      end
    end
  end
end
