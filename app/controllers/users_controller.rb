class UsersController < ApplicationController
  before_filter only: %w(index show) do |controller|
    controller.current_ability(current_user, @user = User.find(params[:user_id] || params[:id]))
  end

  def show
    @ability.authorize! :show, @user

    @places = @user.places.order('created_at desc')
    @checkins = @user.checkins.order('created_at desc')
    @latest_checkin = @checkins.first
    @user_extra = UserExtra.new(:user_id => @user.id)
    if current_user
      @user.get_profile_pic(current_user.token)
    else
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
