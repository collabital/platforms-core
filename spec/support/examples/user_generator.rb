require 'support/examples/generate_model'
require 'support/examples/generate_migration'
require 'support/examples/model_concern'
require 'support/examples/initializer_config'

RSpec.shared_examples "user generator create" do

  before(:each) do
    run_generator run_args
  end

  it_behaves_like "calls #generate model", "user"
  it_behaves_like "does not call #generate migration"
  it_behaves_like "model concern", "AppUser"
  it_behaves_like "initializer user configuration"
end

RSpec.shared_examples "user generator patch" do |model_path|

  let(:flags)  { "--existing-model" }

  before(:each) do
    run_generator run_args
  end

  it_behaves_like "does not call #generate model"
  it_behaves_like "calls #generate migration", "user"
  it_behaves_like "model concern", "AppUser"
  it_behaves_like "initializer user configuration"
end
