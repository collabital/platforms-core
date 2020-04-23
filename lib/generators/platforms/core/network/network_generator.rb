# require "platforms/core/generators/base"
require "generators/platforms/core/base"

module Platforms
  module Core

    # Create a model, with Platforms::Core specific additions for the
    # 'Network' class that should be implemented by the parent
    # application.
    class NetworkGenerator < Platforms::Core::Generators::Base

      # Set the concern_type to network
      def concern_type
        "network"
      end

    end
  end
end
