class FragmentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user
  before_action :correct_user

  def new
  end

  def create
    @fragment = @user.fragments.create(fragment_params)
    response_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    @fragment = @user.fragments.find(params[:id])
    @fragment.update_attributes(fragment_params)
  end

  def destroy
    @fragment = @user.fragments.find(params[:id])
    @fragment.destroy
  end

  private

  def fragment_params
    params.require(:fragment).permit(:video_id, :title, :description)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end
end
