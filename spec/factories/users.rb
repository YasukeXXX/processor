FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      admin true
    end

    trait :activated do
      after(:create) do |user|
        user.account_activation.activate
      end
    end
  end
end
