class VideosController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(id: params[:id])
    params[:video][:path] = uploader.return_path_after_store(params[:video][:video])
    @user.videos.create(video_params)
  end

  private

  def video_params
    params.require(:video).permit(:path)
  end

  def uploader
    @uploader ||= VideoUploader.new
  end
end
