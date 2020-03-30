require 'twitter-text'

module Platforms
  module Core
    # Isolated Rails Engine
    # @see https://guides.rubyonrails.org/engines.html
    class Engine < ::Rails::Engine
      isolate_namespace Platforms::Core

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end

      initializer "platforms.factories", :after => "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)

      end

      # From:
      # https://tanzu.vmware.com/content/blog/leave-your-migrations-in-your-rails-engines
      initializer :append_migrations do |app|
        unless app.root.to_s.match root.to_s
          config.paths["db/migrate"].expanded.each do |expanded_path|
            app.config.paths["db/migrate"] << expanded_path
          end
        end
      end
    end
  end
end
