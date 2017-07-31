require 'rails_helper'

RSpec.describe "VideoUploader", type: :request do
  let(:uploader) { VideoUploader.new }
  let(:video_path) { 'spec/fixtures/video/sample.MOV' }
  let(:video) { fixture_file_upload video_path, 'video/MOV' }

  describe '#return_path_after_store' do
    subject { uploader.return_path_after_store(video) }
    it { is_expected.to eq File.join ['public', uploader.store_dir, video.original_filename] }
  end
end
