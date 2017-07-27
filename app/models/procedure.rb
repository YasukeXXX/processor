class Procedure < ApplicationRecord
  def fragments
    Fragment.where(id: fragments_ids)
  end
end
