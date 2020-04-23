require 'fileutils'

RSpec.shared_context "default initializer" do

  before(:each) do
    templates_path = File.expand_path("../templates", __FILE__)
    initializer_path = File.join(destination_root, "config", "initializers")

    # Create the config/initializers directory
    FileUtils.mkdir_p initializer_path

    FileUtils.cp(
      File.join(templates_path, "platforms_core.rb"),
      File.join(initializer_path, "platforms_core.rb")
    )
  end

end
