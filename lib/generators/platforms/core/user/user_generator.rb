#require "platforms/core/generators/base"
require "generators/platforms/core/base"

module Platforms
  module Core

    # Create a model, with Platforms::Core specific additions for the
    # 'User' class that should be implemented by the parent
    # application.
    class UserGenerator < Platforms::Core::Generators::Base

      # Set the concern_type to user.
      def concern_type
        "user"
      end

    end
  end
end
