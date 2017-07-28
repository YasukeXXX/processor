FactoryGirl.define do
  factory :procedure do
    user_id { create(:user, :activated) }
    fragment_ids { [create(:fragment).id] * 5 }
    title 'title'
    description 'description'
  end
end
