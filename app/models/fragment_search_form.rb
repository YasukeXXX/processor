class FragmentSearchForm
  include ActiveModel::Model
  attr_accessor :keyword
  validates :keyword, length: { maximum: 100 }

  def search
    if valid?
      Fragment.search(keyword)
    else
      nil
    end
  end
end
