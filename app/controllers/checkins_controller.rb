class CheckinsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @checkins = @user.checkins
  end
  
  def sync
    @user = User.find(params[:user_id])
    @user.facebook_checkin_logs.each do |checkin_page|
      Checkin.store_checkins(@user.token, checkin_page.current)
    end
    redirect_to user_path(@user.id)
  end
  
end
