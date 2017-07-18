require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe '#valid' do
    subject { user }
    context 'with right user info' do
      it { is_expected.to be_valid }
    end
  end

  describe '#invalid' do
    subject { user }
    context 'with blank name' do
      before { user.name = ' ' }
      it { is_expected.to be_invalid }
    end

    context 'with blank email' do
      before { user.name = ' ' }
      it { is_expected.to be_invalid }
    end

    context 'with blank password' do
      before do
        user.password = user.password_confirmation = ' '
      end
      it { is_expected.to be_invalid }
    end

    context 'with too long name' do
      before { user.name = 'a' * 100 }
      it { is_expected.to be_invalid }
    end

    context 'with too long email' do
      before { user.email = 'a' * 244 + '@example.com' }
      it { is_expected.to be_invalid }
    end

    context 'with too short password' do
      before do
        user.password = user.password_confirmation = 'passw'
      end
      it { is_expected.to be_invalid }
    end

    context 'with unmatch password confirmation' do
      before { user.password = 'foobar' }
      it { is_expected.to be_invalid }
    end

    context 'with duplicate user' do
      let(:dup_user) { user.dup }
      before { dup_user.save }
      it { is_expected.to be_invalid }
    end

    context 'with name include invalid char' do
      before { user.name = '¥\invalid@#$%^&*()' }
      it { is_expected.to be_invalid }
    end

    context 'with email include invalid char' do
      before { user.email = '¥\invalid@#$%^&*()' }
      it { is_expected.to be_invalid }
    end
  end
end
