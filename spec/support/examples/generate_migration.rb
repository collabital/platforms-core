RSpec.shared_examples "does not call #generate migration" do
  it "any args" do
    expect(mock_gen).not_to have_received(:generate).
      with("migration", any_args)
  end 
end

RSpec.shared_examples "calls #generate migration" do |type|
  it "once" do
    migration_model = model_path.classify.pluralize.gsub("::","")
    args = "AddPlatformsNetworkIdTo#{migration_model} platforms_#{type}_id:integer"
    expect(mock_gen).to have_received(:generate).
      with("migration", args).
      once
  end 
end
