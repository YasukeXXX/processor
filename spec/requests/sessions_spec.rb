require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe '#new' do
    subject { response }
    before { get login_path }
    it { is_expected.to be_success }
    it { is_expected.to render_template 'new' }
  end

  describe '#create' do
    let(:email) { user.email }
    let(:password) { user.password }
    before { post login_path, params: { session: { email: email, password: password } } }

    subject { session[:user_id] }

    context 'with correct user information' do
      it { is_expected.not_to be_nil }
    end

    context 'with wrong password' do
      let(:password) { user.password + 'wrong' }
      it { is_expected.to be_nil }
      it { expect(flash[:error]).not_to be_empty }
      it { expect(response).to render_template 'new' }
    end

    context 'with wrong email' do
      let(:email) { user.email + 'wrong' }
      it { is_expected.to be_nil }
      it { expect(flash[:error]).not_to be_empty }
      it { expect(response).to render_template 'new' }
    end
  end

  describe '#destroy' do
    subject { Proc.new { delete logout_path, params: { id: user.id } } }

    before do
      login_as user
    end

    it { is_expected.to change { session[:user_id] }.from(user.id).to(nil) }
  end
end
