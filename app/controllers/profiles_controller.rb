class ProfilesController < ApplicationController
  def index
    @profile = current_user
    @places = @profile.places
  end
  def show
    @profile = User.find(params[:id])
    @places = @profile.places
  end
end
