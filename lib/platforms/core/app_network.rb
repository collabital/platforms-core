module Platforms
  module Core
    # Add the relevant associations to a Network-type class.
    module AppNetwork
      extend ActiveSupport::Concern

      included do
        # A valid association object is required from Rails 5 onwards,
        # unless otherwise specified.
        belongs_to :platforms_network,
          class_name: "Platforms::Network",
          inverse_of: :app_network

        # Ensure AppNetwork only maps to one Platforms::Network
        validates :platforms_network_id, uniqueness: true
      end
    end
  end
end
