class Devise::IchainSessionsController < DeviseController
  prepend_before_filter :require_no_authentication, :only => [ :new, :test ]

  # GET /resource/sign_in
  def new
    return new_test if ::Devise.ichain_test_mode
    self.resource = build_resource(nil, :unsafe => true)
    @back_url = base_url + after_sign_in_path_for(resource_name)
    # The slash at the end is very important
    @login_url = resource_class.ichain_login_url
    @context = ::Devise.ichain_context
    @proxypath = ::Devise.ichain_proxypath
    respond_with resource
  end

  # DELETE /resource/sign_out
  def destroy
    redirect_url = base_url + after_sign_out_path_for(resource_name)
    if ::Devise.ichain_test_mode
      session.delete :ichain_test_username
      session.delete :ichain_test_attributes
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message :notice, :signed_out if signed_out && is_navigational_format?
      redirect_to redirect_url
    else
      # The final slash is very important, indeed
      logout_url = resource_class.ichain_logout_url
      logout_url += "?" + {:url => redirect_url}.to_query
      redirect_to logout_url
    end
  end

  def test
    redirect_to(:new) unless Devise::ichain_test_mode
    session[:ichain_test_username] = params[:username]
    session[:ichain_test_attributes] = params[:attributes]
    redirect_to after_sign_in_path_for(resource_name)
  end

  protected

  def new_test
    self.resource = build_resource(nil, :unsafe => true)
    @fields = (::Devise.ichain_attribute_headers.keys rescue [])
    @login_url = test_ichain_session_path(resource_name)
    render :new_test
  end

  def base_url
    url = "#{request.protocol}#{request.host}"
    url += ":#{request.port}" unless request.port.blank?
    url
  end
end
