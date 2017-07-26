class Video < ApplicationRecord
  validates :path, presence: true, path_existance: true

  belongs_to :user
  has_many :fragments, dependent: :destroy
end
