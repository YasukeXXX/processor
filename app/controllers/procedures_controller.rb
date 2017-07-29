class ProceduresController < ApplicationController
  def new
    # session.delete(:selected_fragments)
    @procedure = current_user.procedures.build
    @fragment = current_user.fragments.build
    @selected_fragments = Fragment.where(id: session[:selected_fragments])
  end

  def create
  end

  def edit
  end

  def update
  end
end
