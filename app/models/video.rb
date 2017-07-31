class Video < ApplicationRecord
  validates :path, presence: true, path_existance: true

  belongs_to :user
  has_many :fragments, dependent: :destroy

  attr_accessor :video

  before_create :upload_video

  def videos_id
    File.join(path.split('/').slice(2..-1))
  end

  private

  def upload_video
    path = uploader.return_path_after_store(video)
  end

  def uploader
    @uploader ||= VideoUploader.new
  end
end
