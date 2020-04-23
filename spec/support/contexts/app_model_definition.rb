require 'fileutils'

# Must provide model_path as context
# in the form of a string - e.g. "foo/my_bar"
RSpec.shared_context "app model definition" do

  def model_klass
    ActiveSupport::Inflector.camelize(model_path)
  end

  before(:each) do
    *namespace, model_name = model_path.split('/')
    app_models_path = File.join(destination_root, "app", "models", *namespace)
    templates_path = File.expand_path("../templates", __FILE__)

    FileUtils.mkdir_p app_models_path
    model_file = File.join(app_models_path, "#{model_name}.rb")

    src_model = File.read(File.join(templates_path, "my_model.rb"))
    # Substitute class MyModel for class Foo::Bar
    dst_model = src_model.gsub("class MyModel", "class #{model_klass}")
    File.open(model_file, "w") do |f|
      f.write(dst_model)
    end
  end

end
