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
    let(:user) { create(:user) }
    let(:other) { create(:user) }
    before do
      login_as login_user
      get edit_user_path(user)
    end

    subject { response }

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.to redirect_to login_url }
    end

    context 'when not logged in as wrong user' do
      let(:login_user) { other }
      it { is_expected.to redirect_to root_url }
    end

    context 'when logged in as right user' do
      let(:login_user) { user }
      it { is_expected.to be_success }
      it { is_expected.to render_template 'edit' }
    end
  end

  describe '#update' do
    let(:user) { create(:user, :activated) }
    let(:other) { create(:user, :activated) }
    let(:name) { user.name + 'new' }
    let(:email) { user.email + '.new' }
    let(:password) { user.password + 'new' }
    before do
      login_as login_user
      patch user_path user, user: { name: name, email: email, password: password }
      user.reload
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { expect(response).to redirect_to login_url }
      it { expect(user.name).not_to eq name }
      it { expect(user.email).not_to eq email }
    end

    context 'when logged in as wrong user' do
      let(:login_user) { other }
      it { expect(user.name).not_to eq name }
      it { expect(user.email).not_to eq email }
    end

    context 'when logged in as rignt user' do
      let(:login_user) { user }
      it { expect(user.name).to eq name }
      it { expect(user.email).to eq email }
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user, :activated) }
    let!(:admin_user) { create(:user, :admin, :activated) }
    before { login_as login_user }

    subject { Proc.new { delete user_path user } }

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.not_to change { User.count } }
    end

    context 'when logged in as wrong user' do
      let(:login_user) { user }
      it { is_expected.not_to change { User.count } }
    end

    context 'when logged in as admin user' do
      let(:login_user) { admin_user }
      it { is_expected.to change { User.count }.by(-1) }
    end
  end

  describe '#show' do
    let(:user) { create(:user) }
    before do
      login_as user
      get user_path(user)
    end

    subject { response }

    it { is_expected.to render_template 'show' }
    it { expect(response.body).to match /#{user.name}/ }
  end

  describe '#index' do
    let(:user) { create(:user, :activated) }
    let(:admin_user) { create(:user, :admin, :activated) }
    before do
      login_as login_user
      get users_path
    end

    subject { response }

    context 'when not logged in' do
      let(:login_user) { nil }
      it { expect(response).to redirect_to login_path }
    end

    context 'when logged in as user' do
      let(:login_user) { user }
      it { is_expected.to render_template 'index' }
    end

    context 'when logged in as admin user' do
      let(:login_user) { admin_user }
      it { is_expected.to render_template 'index' }
      it { expect(response.body).to include 'delete' }
    end
  end
end
