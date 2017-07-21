class UserWithSendingMail
  def initialize(user)
    @user = user
  end

  def save
    @user.account_activation = account_activation.new
    @user.save && user_mailer.account_activation(@user).deliver_now
  end

  private

  def account_activation
    AccountActivation
  end

  def user_mailer
    UserMailer
  end
end
