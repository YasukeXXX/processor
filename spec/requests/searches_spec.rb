require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:user) { create(:user, :activated) }
  let(:video)  { create(:video, user_id: user.id) }
  let(:fragment) { create(:fragment, user_id: user.id, video_id: video.id) }
  let(:video_path) { 'videos/fixtures/sample.MOV' }

  describe '#index' do
    before do
      allow_any_instance_of(Video).to receive(:videos_id).and_return(video_path)
      get search_index_url user.id, keyword: keyword, format: :js
    end

    context 'when search title' do
      let(:keyword) { fragment.title }
      it { expect(response.body).to include fragment.title }
      it { expect(response.body).to include fragment.description }
      it { expect(response).not_to redirect_to root_url }
    end
  end
end
