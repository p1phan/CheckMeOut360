class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_all_users_without_current_user, :get_all_places
  
  def get_all_users_without_current_user
    @users ||= User.all.select{ |user| user.id != current_user.try(:id) }
  end

  def get_all_places
    @places = Place.all
    if current_user
      @places_for_user = current_user.places
    else
      @places_for_user = []
    end
  end
end
