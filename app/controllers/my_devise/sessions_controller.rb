class MyDevise::SessionsController < Devise::SessionsController

  def new
    flash[:error] = "Sign in unsuccessful"
    resource = build_resource
    clean_up_passwords(resource)
    respond_with_navigational(resource, stub_options(resource)){ render_with_scope :new }
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

end