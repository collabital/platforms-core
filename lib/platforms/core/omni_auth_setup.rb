module Platforms
  module Core

    # Handles the dynamic insertion of client ID and Client Secret
    # into the OmniAuth regime.
    # 
    # @author Benjamin Elias
    # @since 0.1.0
    # @see https://www.createdbypete.com/dynamic-omniauth-provider-setup/ Dynamic providers.
    # @see https://github.com/omniauth/omniauth/wiki/Setup-Phase OmniAuth Setup Phase
    class OmniAuthSetup

      # OmniAuth expects the class passed to setup to respond to the #call
      # method.
      # @param env [Hash] Rack environment
      def self.call(env)
        new(env).setup
      end

      # Assign variables and create a request object for use later.
      # env - Rack environment
      def initialize(env)
        @env = env
        @request = ActionDispatch::Request.new(env)
      end

      # The main purpose of this method is to set the consumer key and secret.
      def setup
        @env['omniauth.strategy'].options.merge!(find_credentials)
      end

      # Use the subdomain in the request to find the account with credentials
      def find_credentials
        strategy = @env['omniauth.strategy'].options.name
        subdomain = ActionDispatch::Http::URL.extract_subdomains(@env['SERVER_NAME'], 0).first

        certificate = Certificate.find_by(
          strategy: strategy,
          name: subdomain
        )
        # If subdomain-specific certificate is not found, use default
        certificate ||= default_certificate
        return certificate.credentials
      end

      # As a placeholder, return a blank certificate
      def default_certificate
        Certificate.new
      end

    end
  end
end
