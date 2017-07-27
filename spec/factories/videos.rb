FactoryGirl.define do
  factory :video do
    user_id { create(:user, :activated).id }
    path 'spec/fixtures/video/sample.MOV'
  end
end
