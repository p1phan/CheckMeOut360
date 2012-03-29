class CheckinsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @checkins = @user.checkins
  end
  
  def sync
    @user = User.find(params[:user_id])
    @checkins = []
    @user.facebook_checkin_logs.each do |checkin_page|
      @checkins += Checkin.store_checkins(@user.token, checkin_page.current)
    end
    Checkin.build_checkins(@checkins, @user.token)
    redirect_to user_path(@user.id)
  end
  
end
