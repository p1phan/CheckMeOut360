class WallsController < ApplicationController
  # GET /walls
  # GET /walls.json

  def index
    if current_user
      get_user_info
    else
      @users = User.all
      @posts = []
    end
  end
  
  def list
    get_wall_info
    respond_to do |format|
      format.js
    end
  end

  # GET /walls/1
  # GET /walls/1.json
  def show
    get_wall_info
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wall }
    end
  end

  # GET /walls/new
  # GET /walls/new.json
  def new
    @wall = Wall.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wall }
    end
  end

  # GET /walls/1/edit
  def edit
    @wall = Wall.find(params[:id])
  end

  # POST /walls
  # POST /walls.json
  def create
    @wall = Wall.new(params[:wall])

    respond_to do |format|
      if @wall.save
        format.html { redirect_to @wall, notice: 'Wall was successfully created.' }
        format.json { render json: @wall, status: :created, location: @wall }
      else
        format.html { render action: "new" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /walls/1
  # PUT /walls/1.json
  def update
    @wall = Wall.find(params[:id])

    respond_to do |format|
      if @wall.update_attributes(params[:wall])
        format.html { redirect_to @wall, notice: 'Wall was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /walls/1
  # DELETE /walls/1.json
  def destroy
    @wall = Wall.find(params[:id])
    @wall.destroy

    respond_to do |format|
      format.html { redirect_to walls_url }
      format.json { head :ok }
    end
  end
  
  def about
    respond_to do |format|
      format.js
    end
  end
  
  def contact
    respond_to do |format|
      format.js
    end
  end
  
  def help
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def get_user_info
    @user = current_user
    @profile = @user.profile
    @user_wall_id = current_user.id 
    @posts = Post.where(:user_id => current_user.id).order("created_at desc")
    @places = @user.places.order("created_at desc")
    @checkins = @user.checkins || []
    @feeds = @posts + @places
    @feeds.sort! {|x,y| x.created_at <=> y.created_at }.reverse!
    
  end
  
  def get_wall_info
    @wall = Wall.find(params[:id])
    @user = @wall.user
    @profile = @user.profile
    @posts = Post.where(:wall_id => @wall.id).order("created_at desc")
    @places = @user.places.order("created_at desc")
    @checkins = @user.checkins || []
    @feeds = @posts + @places
    @feeds.sort! {|x,y| x.created_at <=> y.created_at }.reverse!
  end

end
