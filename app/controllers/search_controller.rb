class SearchController < ApplicationController
  def index
    search_form = FragmentSearchForm.new(keyword: params[:keyword])
    unless @fragments = search_form.search
      redirect_to root_url
    end
  end
end
