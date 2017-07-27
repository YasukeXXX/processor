class Fragment < ApplicationRecord
  belongs_to :user
  belongs_to :video

  def self.search(query)
    query = sanitize_sql_like(query)
    where("title like ? or description like ?", "%#{query}%", "%#{query}%")
  end
end
