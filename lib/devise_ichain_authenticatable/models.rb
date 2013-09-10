module Devise
  module Models
    module IchainAuthenticatable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        # The slashes at the end of the urls looks to be relevant

        def ichain_registration_url
          (::Devise.ichain_base_url || "") + "/ICSLogin/"
        end

        def ichain_login_url
          (::Devise.ichain_base_url || "") + "/ICSLogin/auth-up/"
        end

        def ichain_logout_url
          (::Devise.ichain_base_url || "") + "/ICHAINLogout/"
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
