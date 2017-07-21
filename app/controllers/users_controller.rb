class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user_with_sending_mail = UserWithSendingMail.new(@user)
    if user_with_sending_mail.save
      flash[:info] = "Please check your email to activate your account!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
