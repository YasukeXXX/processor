class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account activation'
  end

  def password_reset(user)
    @user = user
    @token = reset_verifier.generate_token(@user.id)
    mail to: user.email, subject: 'Password reset'
  end

  private

  def reset_verifier
    @reset_verifier ||= Verifier.new type: :reset, expiration_date: 3.hours
  end
end
