ActionDispatch::Routing::Mapper.class_eval do
  protected

  def devise_ichain_session(mapping, controllers)
    resource :ichain_session, :only => [], :controller => controllers[:ichain_sessions], :path => "" do
      get :new, :path => mapping.path_names[:ichain_sign_in], :as => "new"
      post :test, :as => "test"
      match :destroy, :path => mapping.path_names[:ichain_sign_out], :as => "destroy", :via => mapping.sign_out_via
    end
  end

  def devise_ichain_registration(mapping, controllers)
    options = {
      :only => [:new, :edit, :update],
      :path => mapping.path_names[:ichain_registration],
      :path_names => {:new => mapping.path_names[:ichain_sign_up] },
      :controller => controllers[:ichain_registrations]
    }
    resource :ichain_registration, options
  end
end
