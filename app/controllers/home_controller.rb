class HomeController < ApplicationController
  def index
    if logged_in?
      @procedure = current_user.procedures.build
    end
  end
end
