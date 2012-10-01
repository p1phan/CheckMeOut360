class UserExtrasController < ApplicationController
  layout false
  def new
    @user_extra = UserExtra.new(:user_id => params[:user_id])
    render
  end

  def create
    extra = params[:user_extra][:extra]
    unless extra.starts_with?("http://") && params[:user_extra][:link] == "true"
      params[:user_extra][:extra] = "http://#{extra}"
    end
    @user_extra = UserExtra.create(params[:user_extra])
    redirect_to params[:redirect_path]
  end
end
