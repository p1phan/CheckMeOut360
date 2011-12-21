class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    @checkins = Place.get_checkins(@user.token)
    @checkins.each do |checkin|
      place = Place.find_or_initialize_by_name(checkin.place.name)
      if place.new_record?
        place.build_from_checkin(checkin)
        place.save
        @user.places << place
      else
        place.update_attribute(:count, place.count+1)
      end
    end
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
