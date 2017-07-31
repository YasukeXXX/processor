require 'rails_helper'

RSpec.describe "Video", type: :request do
  let(:user) { create(:user, :activated) }
  let(:video_path) { 'spec/fixtures/video/sample.MOV' }
  let(:video) { fixture_file_upload video_path, 'video/MOV' }

  describe '#create' do
    before do
      login_as login_user
      allow_any_instance_of(VideoUploader).to receive(:return_path_after_store).and_return(video_path)
      post user_videos_path user.id, video: { video: video }
    end

    context 'when login' do
      let(:login_user) { user }
      subject { Proc.new { post user_videos_path user.id, video: { video: video } } }
      it { is_expected.to change { Video.count }.by(1) }
      it { expect(response).not_to redirect_to login_url }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { expect(response).to redirect_to login_url }
    end
  end
end
