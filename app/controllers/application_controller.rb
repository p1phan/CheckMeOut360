class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_all_users_without_current_user, :get_all_places, :get_all_checkins
  
  def get_all_users_without_current_user
    @users ||= User.all.select{ |user| user.id != current_user.try(:id) }
  end

  def get_all_places
    @places = Place.order("created_at desc")
  end
  
  def get_all_checkins
    @checkins = Checkin.order("created_at desc")
  end
end
