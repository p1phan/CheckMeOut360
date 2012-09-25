class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :all_users
  
  def all_users
    @active ||= User.active.order("name")
    @inactive ||= User.inactive.order("name")
  end

  def get_user
    @user = User.find(params[:user_id] || params[:id])
  end
  
  def current_ability(current_user, user)
    @ability = Ability.new(current_user, user)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    render partial: "users/unauthorized", :alert => exception.message
  end

  def render_404(exception)
    render :file => "#{Rails.root}/public/404.html", :status => "404 Not Found", layout: false
  end
  
  private 
  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    user_path(current_user.id)
  end
  
end
