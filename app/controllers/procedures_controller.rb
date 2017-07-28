class ProceduresController < ApplicationController
  def new
    @procedure = current_user.procedures.build
    @fragment = current_user.fragments.build
  end

  def create
  end

  def edit
  end

  def update
  end
end
