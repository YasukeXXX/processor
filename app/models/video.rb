class Video < ApplicationRecord
  validates :path, presence: true
  belongs_to :user
end
