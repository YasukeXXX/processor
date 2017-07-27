require 'rails_helper'

RSpec.describe FragmentSearchForm, type: :model do
  describe '#valid' do
    let(:keyword) { 'keyword' }
    subject { build(:fragment_search_form, keyword: keyword).valid? }

    it { is_expected.to be_truthy }
  end

  describe '#invalid' do
    subject { build(:fragment_search_form, keyword: keyword).invalid? }

    context 'when keyword too long' do
      let(:keyword) { 'a' * 101 }
      it { is_expected.to be_truthy }
    end
  end
end
