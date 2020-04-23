require 'spec_helper'
require 'generators/platforms/core/install/install_generator'

module Platforms
  module Core
    RSpec.describe InstallGenerator, type: :generator do
      destination File.expand_path('../../tmp', __FILE__)

      let(:mock_gen) do
        InstallGenerator.new(
          [],
          ["--skip-bundle", "--skip-bootsnap", "--skip-webpack-install"],
          {
            destination_root: File.expand_path('../../tmp', __FILE__),
            shell: Thor::Shell::Basic.new
          }
        )
      end


      before(:each) do
        # Stub out #rake in a known instance
        allow(mock_gen).to receive(:rake)

        # Stub out 'new' method, in order to set the mocked instance
        allow(described_class).to receive(:new).with(
          [],
          ["--skip-bundle", "--skip-bootsnap", "--skip-webpack-install"],
          {
            destination_root: File.expand_path('../../tmp', __FILE__),
            shell: instance_of(Thor::Shell::Basic)
          }
        ).and_return(mock_gen)

        prepare_destination
        run_generator
      end

      it "copies platforms_core.rb initializer" do
        expect(destination_root).to have_structure {
          directory "config" do
            directory "initializers" do
              file "platforms_core.rb" do
                contains "Platforms::Core.configure do |config|"
              end
            end
          end
        }
      end

      it "ran rake 'platforms_core:install:migrations" do
        expect(mock_gen).to have_received(:rake).
          with("platforms_core:install:migrations").
          once
      end

    end
  end
end
