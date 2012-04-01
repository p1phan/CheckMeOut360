class UsersController < ApplicationController
  
  before_filter :access_rights, only: "show"
  def index
    @user = current_user
    @places = @user.places
  end
  
  def show
    @places = @user.places.order('created_at desc')
    @checkins = @user.checkins.order('created_at desc')
    @latest_checkin = @checkins.first
    @allowed_access = false
    if current_user
      @user.get_profile_pic(current_user.token)
      if @user.privacy == User::PUBLIC || (@user.privacy == User::PROTECTED && current_user.friend_with(@user))
        @allowed_access = true
      end
      # @friends = graph.get_connections("me", "friends")
    else
      @allowed_access = true if @user.privacy == User::PUBLIC
      @user.get_profile_pic(User.me.token)
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.privacy = (params[:user][:privacy])
    @user.save
    redirect_to user_path(@user)
  end
end
