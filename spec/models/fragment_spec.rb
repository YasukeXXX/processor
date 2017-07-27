require 'rails_helper'

RSpec.describe Fragment, type: :model do
  describe '#search' do
    let(:find_me) { create(:fragment, title: 'find me', description: 'find me from description') }
    let(:dont_find_me) { create(:fragment) }
    let(:keyword) { find_me.title }
    before { create_list(:fragment, 10) }

    subject { Fragment.search(keyword) }

    context 'when search from title' do
      it { is_expected.to include find_me }
      it { is_expected.not_to include dont_find_me }
    end

    context 'when search from description' do
      let(:keyword) { find_me.description }

      it { is_expected.to include find_me }
      it { is_expected.not_to include dont_find_me }
    end
  end
end
