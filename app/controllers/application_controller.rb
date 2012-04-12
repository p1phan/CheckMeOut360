class ApplicationController < ActionController::Base
  protect_from_forgery

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
end
