class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  autocomplete :place, :name
  
  def index
    @user = User.find(params[:user_id])
    @places = @user.places.order('created_at desc').page(params[:page])
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
