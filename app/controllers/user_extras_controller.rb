class UserExtrasController < ApplicationController
  layout false
  def new
    @user_extra = UserExtra.new(:user_id => params[:user_id])
    render
  end

  def create
    puts ("@@@@@@ params : #{params.inspect}")
    @user_extra = UserExtra.create(params[:user_extra])
    redirect_to params[:redirect_path]
  end
end
