require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { 'example' }
  let(:email) { 'ex@am.ple' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }
  let(:user) do
    build(:user, name: name, email: email, password: password,
                 password_confirmation: password_confirmation)
  end

  describe '#valid' do
    subject { user }
    context 'with right user info' do
      it { is_expected.to be_valid }
    end
  end

  describe '#invalid' do
    subject { user }
    context 'with blank name' do
      let(:name) { ' ' }
      it { is_expected.to be_invalid }
    end

    context 'with blank email' do
      let(:email) { ' ' }
      it { is_expected.to be_invalid }
    end

    context 'with blank password' do
      let(:password) { ' ' }
      let(:password_confirmation) { ' ' }
      it { is_expected.to be_invalid }
    end

    context 'with too long name' do
      let(:name) { 'a' * 100 }
      it { is_expected.to be_invalid }
    end

    context 'with too long email' do
      let(:email) { 'a' * 244 + '@example.com' }
      it { is_expected.to be_invalid }
    end

    context 'with too short password' do
      let(:password) { 'passw' }
      let(:password_confirmation) { 'passw' }
      it { is_expected.to be_invalid }
    end

    context 'with unmatch password confirmation' do
      let(:password) { 'foobar' }
      let(:password_confirmation) { 'barfoo' }
      it { is_expected.to be_invalid }
    end

    context 'with duplicate user' do
      let(:dup_user) { user.dup }
      before { dup_user.save }
      it { is_expected.to be_invalid }
    end

    context 'with name include invalid char' do
      let(:name) { '¥\invalid@#$%^&*()' }
      it { is_expected.to be_invalid }
    end

    context 'with email include invalid char' do
      let(:email) { '¥\invalid@#$%^&*()' }
      it { is_expected.to be_invalid }
    end
  end
end
