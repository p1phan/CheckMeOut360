class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  before_filter :access_rights, only: 'index'
  
  def index
    places = @user.unique_places
    @places = Kaminari.paginate_array(places).page(params[:page])
    @places.each do |place|
      place.get_picture_for_place
    end
  end
  
  def map
    @user = User.find(params[:user_id])
  end

  def all_places
    @user = User.find(params[:user_id])
    @places = @user.places
    respond_to do |format|
      format.json { render :json => @places }
    end
  end
end
