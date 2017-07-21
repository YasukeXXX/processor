class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    if @user = User.find_by(id: params[:id])
      if @user.destroy
        flash[:success] = 'User deleted'
      else
        flash[:error] = 'User delete failed'
      end
    else
      flash[:error] = 'User not exist'
    end
    redirect_to root_url
  end

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    redirect_to login_url unless logged_in?
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
