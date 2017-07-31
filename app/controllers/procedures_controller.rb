class ProceduresController < ApplicationController
  def new
    session.delete(:selected_fragments)
    @procedure = current_user.procedures.build
    @fragment = current_user.fragments.build
    @selected_fragments = Fragment.where(id: session[:selected_fragments])
  end

  def create
    @procedure = current_user.procedures.build(procedure_params)
    @procedure.fragment_ids = session[:selected_fragments]
    if @procedure.save
      flash[:success] = 'Process uploaded'
      redirect_to root_url
    else
      flash[:error] = 'Process upload failed'
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def procedure_params
    params.require(:procedure).permit(:title, :fragment_ids, :description)
  end
end
