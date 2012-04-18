class PlacesController < ApplicationController
  before_filter only: %w(index map) do |controller|
    controller.current_ability(current_user, @user = User.find(params[:user_id] || params[:id]))
  end

  def index
    @ability.authorize! :index, @user

    places = @user.unique_places
    @places = Kaminari.paginate_array(places).page(params[:page])
    token = User.me.token
    graph = Koala::Facebook::API.new(token)
    @places.each do |place|
      place.get_picture_for_place(graph)
    end
  end
  
  def map
    @ability.authorize! :map, @user

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
