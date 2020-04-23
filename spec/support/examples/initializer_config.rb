RSpec.shared_examples "initializer network configuration" do

  it "changes network_class to model" do
    # For some reason, need to have a variable
    # rather than evaluating #model_klass in the
    # argument to #contains.
    network_class = model_klass

    expect(destination_root).to have_structure {
      directory "config" do
        directory "initializers" do
          file "platforms_core.rb" do
            contains "config.network_class = \"#{network_class}\""
          end
        end
      end
    }
  end

  it "leaves user_class unchanged" do
    expect(destination_root).to have_structure {
      directory "config" do
        directory "initializers" do
          file "platforms_core.rb" do
            contains "config.user_class = \"User\""
          end
        end
      end
    }
  end

end

RSpec.shared_examples "initializer user configuration" do

  it "changes user_class to model" do
    # For some reason, need to have a variable
    # rather than evaluating #model_klass in the
    # argument to #contains.
    user_class = model_klass

    expect(destination_root).to have_structure {
      directory "config" do
        directory "initializers" do
          file "platforms_core.rb" do
            contains "config.user_class = \"#{user_class}\""
          end
        end
      end
    }
  end

  it "leaves network_class unchanged" do
    expect(destination_root).to have_structure {
      directory "config" do
        directory "initializers" do
          file "platforms_core.rb" do
            contains "config.network_class = \"Network\""
          end
        end
      end
    }
  end


end
