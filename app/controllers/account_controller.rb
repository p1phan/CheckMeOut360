class AccountController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to root_path notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end
end
