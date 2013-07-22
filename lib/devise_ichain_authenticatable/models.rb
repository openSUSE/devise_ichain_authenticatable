module Devise
  module Models
    module IchainAuthenticatable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
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
