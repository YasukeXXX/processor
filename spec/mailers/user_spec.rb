require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  describe '#account_activation' do
    let(:mail) { UserMailer.account_activation(user) }

    subject { mail.body.encoded }

    it { expect(mail.subject).to eq 'Account activation' }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ['noreply@example.com'] }
    it { is_expected.to include user.name }
    it { is_expected.to include user.account_activation.token }
    it { is_expected.to include CGI.escape(user.email) }
  end

  describe '#password_reset' do
  end
end
