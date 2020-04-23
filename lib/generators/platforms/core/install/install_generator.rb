require 'rails/generators'

module Platforms
  module Core

    # Simplify the installation of Platforms::Core by creating an
    # initializer file and installing the migrations.
    # This does not run the migrations.
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      # Create config/initializers/platforms_core.rb according to the template.
      def copy_initializer_file
        copy_file "platforms_core.rb", "config/initializers/platforms_core.rb"
      end

      # Install the gem's migrations.
      # This is equivalent to the built-in rake task
      # "platforms_core:install:migrations"
      def install_migrations
        rake "platforms_core:install:migrations"
      end

    end
  end
end
