FactoryGirl.define do
  factory :fragment do
    user_id { create(:user, :activated).id }
    video_id { create(:video).id }
    title 'title'
    description 'description'
  end
end
