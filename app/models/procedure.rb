class Procedure < ApplicationRecord
  validates :fragment_ids, presence: true
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  def fragments
    Fragment.where(id: fragment_ids)
  end
end
