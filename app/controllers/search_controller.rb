class SearchController < ApplicationController
  def index
    if params[:keyword]
      search_form = FragmentSearchForm.new(keyword: params[:keyword])
      unless @fragments = search_form.search
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
end
