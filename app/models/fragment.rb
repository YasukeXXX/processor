class Fragment < ApplicationRecord
  belongs_to :user
  belongs_to :video

  attr_accessor :uncreated_video

  after_initialize :create_video

  def self.search(query)
    query = sanitize_sql_like(query)
    where("title like ? or description like ?", "%#{query}%", "%#{query}%")
  end

  private

  def create_video
    self.video = user.videos.create!(video: uncreated_video) if uncreated_video
  end
end
