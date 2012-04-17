class StatisticsController < ApplicationController
  def index
  end
  
  def map
    render layout: 'full_map'
  end
  
  def line
  end
  
  def pie
  end
  
  def bar
  end
  
  def all_places
    @places = Place.all
    respond_to do |format|
      format.json { render :json => @places }
    end
  end
end
