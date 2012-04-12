class HomeController < ApplicationController
  
  def index
    @users = User.all
    if current_user
      redirect_to user_path(current_user)
    end
    
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end

end
