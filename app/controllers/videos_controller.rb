class VideosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    params[:video][:path] = uploader.return_path_after_store(params[:video][:video])
    @user.videos.create!(video_params)
  end

  def show
    @user = User.find(params[:user_id])
    @video = @user.videos.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:path)
  end

  def uploader
    @uploader ||= VideoUploader.new
  end
end
