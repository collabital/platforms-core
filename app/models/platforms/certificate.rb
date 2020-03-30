module Platforms
  # Stores customer-specific certificates for authentication
  class Certificate < ApplicationRecord

    self.table_name = "platforms_certificates"

    # OmniAuth::OAuth2 client ID must exist
    validates :client_id, presence: true

    # OmniAuth::OAuth2 client secret must exist
    validates :client_secret, presence: true

    # The strategy, according to OmniAuth. This allows a customer to
    # have multiple vendor platforms.
    validates :strategy, presence: true

    # Name must exist and be unique
    validates :name, presence: true, uniqueness: true

    validates :strategy, 'platforms/product' => true

    # Show a redacted client_secret for admin purposes.
    # If the client_secret is too short, redacts entirely.
    # Otherwise shows the last 3 characters.
    # @return [String] redacted client_secret
    def client_secret_privacy
      return nil if client_secret.nil?
      return "*****" if client_secret.length < 10
      "*****#{client_secret.last(3)}"
    end

    # Credentials formatted for OmniAuth
    # @return [Hash] with keys of client_id and client_secret
    def credentials
      {
        client_id: client_id,
        client_secret: client_secret
      }
    end
  end
end
