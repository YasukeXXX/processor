class VideosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :set_user

  def new
  end

  def create
    path = uploader.return_path_after_store(params[:video][:video])
    @user.videos.create!(video_params.merge(video: { path: path }))
  end

  def show
    @video = @user.videos.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:path)
  end

  def uploader
    @uploader ||= VideoUploader.new
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
