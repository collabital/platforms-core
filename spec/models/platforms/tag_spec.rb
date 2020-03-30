require 'rails_helper'
require 'support/models/timestamps.rb'

module Platforms
  RSpec.describe Tag, type: :model do

    subject { FactoryBot.create(:tag) }

    it { expect(subject).to be_valid }

    it_behaves_like "has timestamps"

    describe "validations" do
      it { expect(FactoryBot.build(:tag, name: "")).not_to be_valid }
      it { expect(FactoryBot.build(:tag, platforms_network: nil)).not_to be_valid }

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }

        it { expect(alternate).not_to be_valid }

        it "different platforms_network" do
          alternate.platforms_network = FactoryBot.create(:network, :alternate)
          expect(alternate).to be_valid
        end

        it "different name" do
          alternate.name = "#alternate"
          expect(alternate).not_to be_valid
        end
        it "different platform_id" do
          alternate.platform_id = "Alternate"
          expect(alternate).not_to be_valid
        end
        it "different name and platform_id" do
          alternate.platform_id = "Alternate"
          alternate.name = "#alternate"
          expect(alternate).to be_valid
        end
      end

      # Must start with #
      it { expect(FactoryBot.build(:tag, name: "Hello")).not_to be_valid }

      # Must be minimum length 2 (i.e. at least one real character)
      it { expect(FactoryBot.build(:tag, name: "#")    ).not_to be_valid }

    end

    describe "attributes" do
      it { expect(subject).to have_attributes(name: "#hashtag") }
      it { expect(subject).to have_attributes(platform_id: "Tag20") }
      it { expect(subject).to respond_to :platforms_network }
    end

  end
end
