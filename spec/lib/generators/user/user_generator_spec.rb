require 'spec_helper'

require 'support/contexts/app_model_definition'
require 'support/contexts/default_initializer'
require 'support/contexts/mock_rails_generator'

require 'support/examples/user_generator'

require 'generators/platforms/core/user/user_generator'

module Platforms
  module Core
    RSpec.describe UserGenerator, type: :generator do
      # This must be first, before any of the patching for files
      before(:each) { prepare_destination }

      describe "check inheritance" do
        # This covers off on the requirement for an argument
        it { expect(described_class).to be < Rails::Generators::NamedBase }
      end

      describe "run generator" do
        let(:mock_methods) { [:generate] }

        include_context "mock rails generator"
        include_context "app model definition"
        include_context "default initializer"

        destination File.expand_path('../../tmp', __FILE__)

        # New class
        it_behaves_like "user generator create" do
          let(:model_path) { "widget" }
        end
        # New class with schema
        it_behaves_like "user generator create" do
          let(:model_path) { "widget" }
          let(:schema) { "level:int:index name:string" }
        end
        # Existing class
        it_behaves_like "user generator patch" do
          let(:model_path) { "widget" }
        end
        # New namespaced class with schema
        it_behaves_like "user generator create" do
          let(:model_path) { "foo/my_widget" }
          let(:schema) { "level:int:index name:string" }
        end
        # Existing namespaced class
        it_behaves_like "user generator patch" do
          let(:model_path) { "foo/my_widget" }
        end
      end
    end
  end
end
