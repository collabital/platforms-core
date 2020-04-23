RSpec.shared_examples "model concern" do |concern|
  it {
    rails_model_path = model_path.split("/")
    file_path = File.join(destination_root, "app", "models", *rails_model_path)
    dir_path = File.dirname(file_path)

    expect(dir_path).to have_structure {
      file "#{rails_model_path.last}.rb" do
        contains "include Platforms::Core::#{concern}"
      end
    }
  }
end
