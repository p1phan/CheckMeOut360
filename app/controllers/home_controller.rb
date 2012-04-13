class HomeController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end

end
