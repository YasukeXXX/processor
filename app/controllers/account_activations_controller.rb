class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.account_activation.verify(params[:id])
      user.account_activation.activate
      login user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:error] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
