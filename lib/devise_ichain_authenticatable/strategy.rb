require 'devise/strategies/authenticatable'

class Devise::Strategies::IchainAuthenticatable < Devise::Strategies::Authenticatable

  def store?
    false
  end

  def valid?
    ::Devise.ichain_test_mode || !request.env[::Devise.ichain_username_header].blank?
  end

  def authenticate!
    proxy_user = nil
    if ::Devise.ichain_test_mode
      if ::Devise.ichain_force_test_username
        proxy_user = ::Devise.ichain_force_test_username.to_s
      elsif session[:ichain_test_username]
        proxy_user = session[:ichain_test_username]
      end
      if ::Devise.ichain_force_test_attributes
        attributes = ::Devise.ichain_force_test_attributes
      else
        attributes = session[:ichain_test_attributes] || {}
      end
    else
      proxy_user = request.env[::Devise.ichain_username_header]
      attributes = {}
      ::Devise.ichain_attribute_headers.each do |k,v|
        attributes[k.to_sym] = request.env[v]
      end
    end
    if proxy_user
      resource = mapping.to.for_ichain_username(proxy_user, attributes)
      return fail! unless resource
      resource.signed_in_by_ichain!
      success!(resource)
    else
      fail!
    end
  end
end

Warden::Strategies.add :ichain_authenticatable, Devise::Strategies::IchainAuthenticatable
