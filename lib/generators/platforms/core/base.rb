require "rails/generators/active_record"

module Platforms
  module Core
    # Generators to simpify installing Platforms::Core
    module Generators

      # These are common functions that apply to both User and Network model types.
      # The setup for both is really quite similar:
      # * Generating a model, or creating a migration to add an association column
      # * Add the relevant Concern to the Model
      # * Update the initializer to reference the new class
      class Base < Rails::Generators::NamedBase
        include ActiveRecord::Generators::Migration

        source_root File.join(__dir__, "templates")

        argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

        # Don't do check_class_collision here. It can be done within
        # create_model instead, if required.

        class_option :migration, type: :boolean
        class_option :timestamps, type: :boolean
        class_option :parent, type: :string, desc: "The parent class for the generated model"
        class_option :indexes, type: :boolean, default: true, desc: "Add indexes for references and belongs_to columns"
        class_option :primary_key_type, type: :string, desc: "The type for primary key"
        class_option :database, type: :string, aliases: %i(--db), desc: "The database for your model's migration. By default, the current environment's primary database is used."

        # Platforms-specific class option
        class_option :existing_model, type: :boolean, default: false, desc: "Use existing model. Do not generate a new model definition"

        # Create the model, unless --existing_model is specified.
        # Calls the standard rails model generator, so should accept similar arguments
        # to 'rails g model Foo'.
        def create_model
          return if options[:existing_model]
          args = [name]
          args << "platforms_#{concern_type}_id:integer"

          # Recreate arguments
          attributes.each do |a|
            args << "#{a.name}:#{a.type}#{a.has_index? ? ":index" : "" }"
          end

          # Recreate options
          options.each do |k, v|
            unless k == "existing_model"
              args << "--#{k}=#{v}"
            end
          end

          # Use the standard model generator
          generate "model", args.join(" ")
        end

        # Create a migration, when a model already exists.
        # This could be for platforms_network_id or platforms_user_id.
        def create_migration
          return unless options[:existing_model]
          migration_name = table_name.classify.pluralize
          args = "AddPlatformsNetworkIdTo#{migration_name} platforms_#{concern_type}_id:integer"
          generate "migration", args
        end

        # Adds the relevant concern to the network or user model.
        # This is either Platforms::Core:AppNetwork or Platforms::Core::AppUser
        # #file_name is inherited from Rails::Generators::NamedBase, according
        # to https://guides.rubyonrails.org/generators.html
        def add_concern_to_model

          # Add the concern line
          model_file_path = File.join("app", "models", class_path, "#{file_name}.rb")
          inject_into_class model_file_path, class_name do
            "  include Platforms::Core::App#{concern_type.capitalize}\n\n"
          end
        end

        # Set a line in the initializer to 'config.network_class = "Network"'
        # or similar. This could also be 'config.user_class = "MyUser"'
        #
        # Rather than gsub, matching config lines are removed and then added again.
        def edit_initializer
          init = "config/initializers/platforms_core.rb"
          gsub_file init, /\s*config.#{concern_type}_class\s+= .*\n/, "\n"

          inject_into_file init, after: "Platforms::Core.configure do |config|\n" do
            "  config.#{concern_type}_class = \"#{class_name}\"\n"
          end

        end

      end
    end
  end
end
