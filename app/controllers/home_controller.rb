class HomeController < ApplicationController
  def index
    if logged_in?
      @procedures = current_user.procedures
    end
  end
end
