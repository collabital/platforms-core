module Platforms
  module Core

    # Configuration pattern for Rails, allows defaults and initializers to
    # override those defaults.
    # @see https://stackoverflow.com/a/24151439 Stack Overflow
    class << self

      # Get the configuration
      # @return [Platforms::Configuration] the current configuration
      def configuration
        @configuration ||= Configuration.new
      end

      # Used by initializers to set the configuration
      # @yield [configuration] provides the configuration context
      def configure
        yield configuration
      end
    end

    # The class which stores the gem's configuration
    # Should only store core configuration, not related to each product.
    class Configuration
      include ActiveSupport::Configurable

      ##
      # The default name for the main application's user class.
      # @see Platforms::User
      # (defaults: ::User)
      config_accessor(:user_class)    { "::User" }


      ##
      # The default name for the main application's network class.
      # @see Platforms::Network
      # (defaults: ::Network)
      config_accessor(:network_class) { "::Network" }

    end
  end
end
