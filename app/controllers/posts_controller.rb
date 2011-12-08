class PostsController < ApplicationController

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user
      @post = Post.new(params[:post])
      @post.user_id = current_user.id
      respond_to do |format|
        if @post.save
          @posts = Post.find_all_by_wall_id(@post.wall.id)|| []
          format.js
        else
          flash[:error] = "Problem creating post!"
          render :partial => 'shared/flash', :locals => {:flash => flash}
        end
      end
    else
      flash[:error] = "You are not signed n!"
      render :partial => 'shared/flash', :locals => {:flash => flash}
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
end
