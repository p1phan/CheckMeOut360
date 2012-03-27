class UsersController < ApplicationController
  def index
    @user = current_user
    @places = @user.places
  end
  def show
    @user = User.find(params[:id])
    @places = @user.places.order('created_at desc')
    @checkins = @user.checkins.order('created_at desc')
    @latest_checkin = @checkins.first
  end
end
