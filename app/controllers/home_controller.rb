class HomeController < ApplicationController
  
  def index
    @all_checkins = Kaminari.paginate_array(Checkin.find(:all, order: "created_at desc")).page(params[:page])
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end
end
