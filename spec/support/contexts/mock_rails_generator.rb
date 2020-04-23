RSpec.shared_context "mock rails generator" do
  let(:schema) { "" }
  let(:flags)  { "" }

  def run_args
    args = [model_path] + schema.split + flags.split
    args.reject { |c| c.empty? }
  end

  let(:generator_args) do
    args = [model_path] + schema.split
    args.reject { |c| c.empty? }
  end

  let(:mock_args) { generator_args }
  let(:default_flags) {
    ["--skip-bundle", "--skip-bootsnap", "--skip-webpack-install"]
  }
  let(:generator_flags) { default_flags + flags.split }
  let(:mock_flags) { generator_flags }

  def destination_root
    self.test_case.destination_root
  end

  let(:mock_gen) do
    described_class.new(
      mock_args,
      mock_flags,
      {
        destination_root: destination_root,
        shell: Thor::Shell::Basic.new
      }
    )
  end

  before(:each) do

    # Stub out methods in a known instance. Make this general
    # (no argument matching), to catch out any rogue arguments.
    mock_methods.each do |m|
      allow(mock_gen).to receive(m)
    end

    # Stub out 'new' method, in order to set the mocked instance
    allow(described_class).to receive(:new).with(
      generator_args,
      match_array(generator_flags),
      {
        destination_root: destination_root,
        shell: instance_of(Thor::Shell::Basic)
      }
    ).and_return(mock_gen)
  end

end
