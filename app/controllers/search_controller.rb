class SearchController < ApplicationController
  protect_from_forgery except: :index

  def index
    if params[:keyword]
      search_form = FragmentSearchForm.new(keyword: params[:keyword])
      @searched_fragments = search_form.search
    end
    respond_to do |format|
      format.js
    end
  end
end
