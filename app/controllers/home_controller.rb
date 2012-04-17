class HomeController < ApplicationController
  
  def index
    @all_checkins = Checkin.find(:all, limit: 10, order: "created_at desc")
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end

end
