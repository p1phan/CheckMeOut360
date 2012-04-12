class CheckinsController < ApplicationController
  before_filter only: %w(index) do |controller|
    controller.current_ability(current_user, @user = User.find(params[:user_id] || params[:id]))
  end
  
  def index
    @ability.authorize! :index, @user

    @checkins = @user.checkins.order('created_at desc').page(params[:page])
  end
  
  def sync
    @user = User.find(params[:user_id])
    @checkins = []
    @user.facebook_checkin_logs.each do |checkin_page|
      @checkins += Checkin.store_checkins(@user.token, checkin_page.current)
    end
    Checkin.build_checkins(@checkins)
    redirect_to user_path(@user.id)
  end
  
end
