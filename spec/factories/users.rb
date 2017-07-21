FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    account_activation { build :account_activation }

    trait :admin do
      admin true
    end

    trait :activated do
      after(:create) do |user|
        user.activate
      end
    end
  end
end
