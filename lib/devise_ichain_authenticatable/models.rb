module Devise
  module Models
    module IchainAuthenticatable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def ichain_url_for(action)
          URI::join(::Devise.ichain_base_url || "",
                    ::Devise.send(:"ichain_#{action}_path")).to_s
        end

        def ichain_registration_url
          ichain_url_for(:registration)
        end

        def ichain_login_url
          ichain_url_for(:login)
        end

        def ichain_logout_url
          ichain_url_for(:logout)
        end
      end

      def signed_in_by_ichain!
        @signed_in_by_ichain = true
      end

      def signed_in_by_ichain?
        @signed_in_by_ichain == true
      end
    end

    # Empty, but Devise seems to require a model per module
    module IchainRegisterable
    end
  end
end
