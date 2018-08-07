require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:user) { create(:user, :activated) }
  let(:path) { 'spec/fixtures/video/sample.MOV' }
  let(:video) { build(:video, user_id: user.id, path: path) }

  describe '#valid' do
    subject { video }
    it { is_expected.to be_valid }
  end

  describe '#invalid' do
    subject { video }

    context 'with not-exists video path' do
      let(:path) { 'no/exists/path' }
      it { is_expected.to be_invalid }
    end

    context 'with path blanck' do
      let(:path) { '' }
      it { is_expected.to be_invalid }
    end
  end
end
