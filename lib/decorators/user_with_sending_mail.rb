class UserWithSendingMail
  def initialize(user)
    @user = user
  end

  def save
    @user.save && UserMailer.account_activation(@user).deliver_now
  end
end
