require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe '#new' do
    before { get signup_path }
    subject { response }

    it { is_expected.to be_success }
    it { is_expected.to render_template 'new' }
  end

  describe '#create' do
    let(:name) { 'example' }
    let(:email) { 'example@example.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }
    let(:user) do
      build(:user, name: name, email: email, password: password,
                   password_confirmation: password_confirmation)
    end

    describe 'Default' do
      before do
        post signup_path, params: { user: { name: user.name, email: user.email,
                                            password: user.password,
                                            password_confirmation: user.password_confirmation } }
      end

      context 'with correct user info' do
        it { expect(flash[:info]).not_to be_nil }
        it { expect(session[:user_id]).to be_nil }
      end

      context 'with wrong email' do
        let(:email) { 'aaa' }

        it { expect(flash[:success]).to be_nil }
        it { expect(session[:user_id]).to be_nil }
      end
    end

    describe 'Mailer' do
      subject do
        Proc.new do
          post signup_path, params: { user: { name: user.name, email: user.email,
                                              password: user.password,
                                              password_confirmation: user.password_confirmation } }
        end
      end

      context 'with correct user info' do
        it { is_expected.to change { ActionMailer::Base.deliveries.count }.by(1) }
      end

      context 'with wrong user info' do
        let(:email) { 'aaa' }
        it { is_expected.not_to change { ActionMailer::Base.deliveries.count } }
      end
    end
  end

  describe '#edit' do
  end

  describe '#show' do
    let(:user) { create(:user) }
    before { get user_path(user) }
    subject { response }

    it { is_expected.to render_template 'show' }
    it { expect(response.body).to match /#{user.name}/im }
  end
end
