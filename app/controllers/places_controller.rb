class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  def index
    wall = Wall.find_by_slug(params[:wall_id])
    @places = User.find(wall.user_id).places

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def new
    @place = Place.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end
  
  def list
    @wall = Wall.find(params[:id])
    @places = User.find(@wall.user_id).places
    respond_to do |format|
      format.js
    end
  end
  
  def all_places
    wall = Wall.find(params[:id])
    places = User.find(wall.user_id).places
    respond_to do |format|
      format.json { render :json => places }
    end
  end

  # POST /places
  # POST /places.json
  def create
    if current_user
      place = Place.new(params[:place])
      place.geocode
      @place = Place.find_or_initialize_by_lat_and_long(place.lat, place.long)
      respond_to do |format|
        if @place.new_record?
          result = @place.update_attributes(params[:place])
          current_user.places << @place
        else
          result = @place.update_attribute(:count, @place.count + 1)
        end
        if result
          @places = current_user.places
          format.html { redirect_to @place, notice: 'Place was successfully created.' }
          format.js
        else
          format.html { render action: "new" }
          format.js
        end
      end
    else
      flash[:error] = "You are not signed in!"
      render :partial => 'shared/flash', :locals => {:flash => flash}
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :ok }
    end
  end
end
