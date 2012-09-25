class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def facebook
    puts "!!!! IN FACEBOOK #{request.env['omniauth.auth'].inspect.to_s}"
    m = Messenger.new(session_id: 1, data: request.env['omniauth.auth'].to_s)
    m.save!
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    # @checkins = Checkin.get_checkins_facebook_url(@user)
    if @checkins.instance_of? Koala::Facebook::APIError
      render_404(@checkins)
    else
      Checkin::build_checkins(@checkins)
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to root_path
      end
    end
  end
end
