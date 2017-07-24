class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      flash[:info] = 'Email send with password reset instructions'
      @user.reset_token = reset_verifier.generate_token(@user.id)
      user_mailer.password_reset(@user).deliver_now
      redirect_to root_url
    else
      flash[:error] = 'User account not exists'
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].nil?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      login @user
      flash[:success] = 'Password has been reset'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def reset_verifier
    @reset_verifier ||= Verifier.new type: :reset, expiration_date: 3.hours
  end

  def user_mailer
    UserMailer
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.account_activation.activated? && reset_verifier.verify(params[:id])
      redirect_to root_url
    end
  end
end
