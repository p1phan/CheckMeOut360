class CheckinsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @checkins = @user.checkins
  end
  
end
