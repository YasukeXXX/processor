require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:user) { create(:user, :activated) }
  let(:video)  { create(:video, user_id: user.id) }
  let(:fragment) { create(:fragment, user_id: user.id, video_id: video.id) }
  describe '#index' do
    before { get search_index_url user.id, keyword: keyword }

    context 'when search title' do
      let(:keyword) { fragment.title }
      # it { expect(assigns(:fragment)).to include fragment }
      it { expect(response).not_to redirect_to root_url }
    end
  end
end
