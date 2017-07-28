class ProceduresController < ApplicationController
  def new
    @procedure = current_user.procedures.build
  end

  def create
  end

  def edit
  end

  def update
  end
end
