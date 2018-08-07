class Video < ApplicationRecord
  validates :path, presence: true, path_existance: true

  belongs_to :user
  has_many :fragments, dependent: :destroy

  def videos_id
    File.join(path.split('/').slice(2..-1))
  end
end
