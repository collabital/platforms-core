require 'rails_helper'
require 'support/examples/timestamps.rb'
require 'support/examples/products.rb'

module Platforms
  RSpec.describe Network, type: :model do

    subject { FactoryBot.create(:network) }

    it { expect(subject).to be_valid }

    it_behaves_like "has timestamps"
    it_behaves_like "is a product", :platform_type

    describe "traits" do
      it { expect(FactoryBot.build(:network, :alternate)).to be_valid }
    end

    describe "validations" do
      it { expect(FactoryBot.build(:network, name: "")        ).not_to be_valid }
      it { expect(FactoryBot.build(:network, permalink: "")   ).not_to be_valid }
      it { expect(FactoryBot.build(:network, platform_id: "") ).not_to be_valid }
      it { expect(FactoryBot.build(:network, trial: nil)      ).not_to be_valid }
      it { expect(FactoryBot.build(:network, trial: true)     ).to be_valid }
      it { expect(FactoryBot.build(:network, trial: false)    ).to be_valid }

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }

        it { expect(alternate).not_to be_valid }

        it "different platform_id" do
          alternate.platform_id = "Alternate"
          expect(alternate).to be_valid
        end

        it "different platform_type" do
          alternate.platform_type = "gizmo"
          expect(alternate).to be_valid
        end
      end
    end

    describe "attributes" do
      it { expect(subject).to have_attributes(name: "Acme") }
      it { expect(subject).to have_attributes(permalink: "acme-com") }
      it { expect(subject).to have_attributes(platform_type: "widget") }
      it { expect(subject).to have_attributes(platform_id: "1") }
      it { expect(subject).to have_attributes(trial: false) }
    end

    describe "#app_network" do
      let!(:app_network) {
        FactoryBot.create(:app_network, platforms_network_id: subject.id)
      }

      it { expect(subject.app_network).not_to be_nil }
      it { expect(subject.app_network).to be_a ::SampleNetwork }
      it { expect(subject.app_network).to eql(app_network) }
    end

    describe "#app_network configurable" do
      pending "test whether Application::Network is configurable"
=begin
      # The following code works in isolation, but then it appears that
      # FactoryBot cannot use Platform::Network classes for subsequent
      # tests (e.g. Tag). So this cannot be the correct way to test this.

      subject { Network.reflect_on_association(:app_network).class_name }

      describe "dummy app's configuration" do
        it { expect(subject).to eq "SampleNetwork" }
      end

      describe "bespoke configuration" do
        # Save the previous configuration
        let!(:app_config) { Platforms.configuration.network_class }

        before(:each) do
          Platforms.configuration.network_class = "MyNetwork"
          Platforms.send(:remove_const, :Network)
          load 'app/models/platforms/network.rb'
        end

        after(:each) do
          Platforms.configuration.network_class = app_config
          Platforms.send(:remove_const, :Network)
          load 'app/models/platforms/network.rb'
        end

        it { expect(subject).to eq "MyNetwork" }
      end

      describe "check dummy app's configuration is restored" do
        it { expect(subject).to eq "SampleNetwork" }
      end
=end
    end
  end
end
