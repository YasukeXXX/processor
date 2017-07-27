require 'rails_helper'

RSpec.describe "AccountActivation", type: :request do
  let(:user) { create(:user) }

  describe "#edit" do
    before do
      get edit_account_activation_path(token, email: user.email)
      user.reload
    end

    context 'with correct token' do
      let(:token) { user.account_activation.token }

      it { expect(user.account_activation.activated).to be_truthy }
      it { expect(is_loggedin?).to be_truthy }
      it { expect(flash[:success]).not_to be_nil }
      it { expect(flash[:error]).to be_nil }
    end

    context 'with wrong token' do
      let(:token) { "wrong token" }

      it { expect(user.account_activation.activated).to be_falsy }
      it { expect(is_loggedin?).to be_falsy }
      it { expect(flash[:success]).to be_nil }
      it { expect(flash[:error]).not_to be_nil }
    end
  end
end
