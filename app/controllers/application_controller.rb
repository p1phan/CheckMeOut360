class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def access_rights
    @user = User.find(params[:user_id] || params[:id])
    @allowed_access = false
    if @user.privacy == User::PUBLIC || (@user.privacy == User::PROTECTED && current_user && current_user.friend_with(@user))
      @allowed_access = true
    else
      @allowed_access = true if @user.privacy == User::PUBLIC
    end
  end
end
