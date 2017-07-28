require 'rails_helper'

RSpec.describe Procedure, type: :model do
  let(:user) { create(:user, :activated) }
  let(:user_id) { user.id }
  let(:fragment_ids) { [create(:fragment)] * 5 }
  let(:title) { 'test title' }
  let(:description) { 'test description' }

  let(:procedure) do
    build :procedure,
          user_id: user_id,
          fragment_ids: fragment_ids,
          title: title,
          description: description
  end

  describe '#valid' do
    subject { procedure }

    context 'with correct information' do
      it { is_expected.to be_truthy }
    end
  end

  describe '#invalid' do
    subject { procedure }

    context 'when title blank' do
      let(:title) { ' ' }
      it { is_expected.to be_truthy }
    end

    context 'when description blank' do
      let(:description) { ' ' }
      it { is_expected.to be_truthy }
    end
  end
end
