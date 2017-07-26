require 'rails_helper'

RSpec.describe "Video", type: :request do
  let(:user) { create(:user, :activated) }
  let(:video) { fixture_file_upload 'spec/fixtures/video/sample.MOV', 'video/MOV' }

  describe '#create' do
    before do
      login_as login_user
      post user_videos_path user.id, video: { video: video }
    end

    context 'when login' do
      let(:login_user) { user }
      # subject { Proc.new { post user_videos_path user.id, video: { video: video } } }
      # it { is_expected.to change { Video.count }.by(1) }
      # it { expect(response).not_to redirect_to login_url }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { expect(response).to redirect_to login_url }
    end
  end
end
