class Devise::IchainRegistrationsController < DeviseController
  prepend_before_action :require_no_authentication, :only => [ :new ]
  prepend_before_action :authenticate_scope!, :only => [:edit, :update]

  def new
    redirect_url = base_url + after_sign_up_path_for(resource_name)
    if ::Devise.ichain_test_mode
      set_flash_message :alert, :in_test_mode
      redirect_to redirect_url
    else
      sign_up_url = resource_class.ichain_registration_url
      sign_up_url += "?" + {:url => redirect_url}.to_query
      redirect_to sign_up_url
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  def update
    if resource.update_attributes(resource_params)
      set_flash_message :notice, :updated
    else
      set_flash_message :alert, :update_failed
    end
    respond_with resource, :location => after_update_path_for(resource)
  end

  protected

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", :force => true)
    self.resource = send(:"current_#{resource_name}")
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def base_url
    url = "#{request.protocol}#{request.host}"
    url += ":#{request.port}" unless request.port.blank?
    url
  end
end
