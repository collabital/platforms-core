RSpec.shared_examples "does not call #generate model" do
  it "any args" do
    expect(mock_gen).not_to have_received(:generate).
      with("model", any_args)
  end
end

RSpec.shared_examples "calls #generate model" do |type|
  it "once" do
    args = "#{model_path} platforms_#{type}_id:integer"
    args << " #{schema}" unless schema.empty?
    args << " --skip_namespace=false --indexes=true"
    expect(mock_gen).to have_received(:generate).
      with("model", args).
      once
  end
end
