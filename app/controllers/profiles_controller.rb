class ProfilesController < ApplicationController
  def index
    @user = current_user
    @places = @user.places
  end
  def show
    @user = User.find(params[:id])
    @places = @user.places
    @checkins = @user.checkins.reverse
  end
end
