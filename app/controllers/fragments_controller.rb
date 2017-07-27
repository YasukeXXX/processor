class FragmentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user
  before_action :correct_user

  def new
  end

  def create
    @user.fragments.create(fragment_params)
  end

  def edit
  end

  def update
    @fragment = @user.fragments.find(params[:id])
    if @fragment.update_attributes(fragment_params)
      flash[:success] = 'Fragment updated!'
    else
      flash[:error] = 'Fragment update failed'
    end
  end

  def destroy
    @fragment = @user.fragments.find(params[:id])
    if @fragment.destroy
      flash[:success] = 'Fragment deleted!'
    else
      flash[:error] = 'Fragment delete failed'
    end
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
