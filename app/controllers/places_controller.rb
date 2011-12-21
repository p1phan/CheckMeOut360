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
      format.html # show.html.erb
      format.json { render json: @place }
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

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.json
  def create
    if current_user
      @place = Place.new(params[:place])
      respond_to do |format|
        if @place.save
          current_user.places << @place
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

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
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
