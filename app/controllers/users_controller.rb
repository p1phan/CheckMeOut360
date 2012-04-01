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
    if current_user
      token = current_user.token
      graph = Koala::Facebook::API.new(token)
      @friends = graph.get_connections("me", "friends")
    elsif @user.privacy == User::PUBLIC
    else
      
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end
end
