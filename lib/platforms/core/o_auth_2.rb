module Platforms
  module Core

    # This is a module for common authentication methods, across multiple
    # platforms.
    # @todo extract out the common functionality.
    module OAuth2
      extend ActiveSupport::Concern

      # Get the token from the OmniAuth credentials store
      # A convenience method.
      # @return the OmniAuth auth token
      def token
        request.env["omniauth.auth"].credentials.token
      end

      # Sometimes the return value is a string "true", while others it is
      # cast as a boolean. This normalises that behaviour to true or false.
      # Any non-"true" String value should return false.
      # @param val [Object] value to convert
      # @return boolean equivalent
      def bool_safe val
        return val == "true" if val.is_a? String
        val.eql?(true)
      end

    end
  end
end
