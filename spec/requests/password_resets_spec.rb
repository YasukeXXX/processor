require 'rails_helper'

RSpec.describe "PasswordReset", type: :request do
  let(:user) { create(:user, :activated) }
  let(:unactivated_user) { create(:user) }
  let(:reset_verifier) { Verifier.new type: :reset, expiration_date: 3.hours }

  describe '#new' do
    before { get new_password_reset_url }
    it { expect(response).to be_success }
  end

  describe '#create' do
    let(:email) { user.email }
    before { post password_resets_url password_reset: { email: email } }

    context 'with correct email' do
      it { expect(response).to redirect_to root_url }
      it { expect(flash[:info]).not_to be_nil }
      it { expect(flash[:error]).to be_nil }
    end

    context 'with wrong email' do
      let(:email) { user.email + 'wrongemail' }
      it { expect(response).to render_template 'new' }
      it { expect(flash[:info]).to be_nil }
      it { expect(flash[:error]).not_to be_nil }
    end
  end

  describe "#edit" do
    let(:email) { user.email }
    let(:token) { reset_verifier.generate_token user.id }
    before do
      get edit_password_reset_path(token, email: email)
    end

    context 'with correct token' do
      it { expect(response).to render_template 'edit' }
    end

    context 'with wrong user' do
      let(:email) { user.email + 'wrongemail' }
      it { expect(response).to redirect_to root_url }
    end

    context 'with unactivated user' do
      let(:email) { unactivated_user }
      let(:token) { reset_verifier.generate_token unactivated_user.id }
      it { expect(response).to redirect_to root_url }
    end

    context 'with wrong token' do
      let(:token) { "wrong token" }
      it { expect(response).to redirect_to root_url }
    end
  end

  describe '#update' do
    let(:email) { user.email }
    let(:token) { reset_verifier.generate_token user.id }
    let(:password) { 'new' + user.password }
    let(:password_confirmation) { 'new' + user.password }
    before do
      patch password_reset_url token, user: { password: password,
                                              password_confirmation: password_confirmation },
                                      email: email
      user.reload
    end

    context 'with correct user' do
      it { expect(response).to redirect_to user }
      it { expect(user.authenticate(password)).to be_truthy }
      it { expect(flash[:success]).not_to be_nil }
    end

    context 'with wrong user' do
      let(:email) { user.email + 'wrongemail' }
      it { expect(response).to redirect_to root_url }
      it { expect(user.authenticate(password)).to be_falsy }
    end

    context 'with unactivated user' do
      let(:email) { unactivated_user }
      let(:token) { reset_verifier.generate_token unactivated_user.id }
      it { expect(response).to redirect_to root_url }
      it { expect(user.authenticate(password)).to be_falsy }
    end

    context 'with wrong token' do
      let(:token) { "wrong token" }
      it { expect(response).to redirect_to root_url }
    end

    context 'when password blanck' do
      let(:password) { '' }
      let(:password_confirmation) { '' }
      it { expect(response).to render_template 'edit' }
      it { expect(user.authenticate(password)).to be_falsy }
    end
  end
end
