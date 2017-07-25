require 'rails_helper'

RSpec.describe "Video", type: :request do
  let(:user) { create(:user, :activated) }

  describe '#create' do
    context 'when video upload' do
      let(:video) { fixture_file_upload 'spec/fixtures/video/sample.MOV', 'video/MOV' }
      subject { Proc.new { post videos_path user.id, video: { video: video } } }

      it { is_expected.to change { Video.count }.by(1) }
    end
  end
end
