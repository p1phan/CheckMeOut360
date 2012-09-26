class HomeController < ApplicationController

  def index
    @all_checkins = Kaminari.paginate_array(Checkin.find(:all, order: "created_at desc")).page(params[:page])
  end

  def about
  end

  def contact
  end

  def who
    members = %w(Quy\ Phan Phu\ Phan Michael\ Luong Tan\ Cao Jake\ Pham)
    @users = []
    members.each do |member|
      user = User.find_by_name(member)
      user.get_profile_pic(user.token)
      @users << user
    end

  end

  def help
  end
end
