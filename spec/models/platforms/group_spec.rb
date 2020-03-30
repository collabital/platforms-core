require 'rails_helper'
require 'support/models/timestamps.rb'

module Platforms
  RSpec.describe Group, type: :model do

    subject { FactoryBot.create(:group) }

    it { expect(subject).to be_valid }

    it_behaves_like "has timestamps"

    describe "validations" do
      it { expect(FactoryBot.build(:group, name: "")).not_to be_valid }
      it { expect(FactoryBot.build(:group, platform_id: "")).not_to be_valid }
      it { expect(FactoryBot.build(:group, platforms_network: nil)).not_to be_valid }

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }

        it { expect(alternate).not_to be_valid }

        it "different platforms_network" do
          alternate.platforms_network = FactoryBot.create(:network, :alternate)
          expect(alternate).to be_valid
        end

        it "different platform_id" do
          alternate.platform_id = "Alternate"
          expect(alternate).to be_valid
        end
      end
    end

    describe "attributes" do
      it { expect(subject).to have_attributes(platform_id: "Group1") }
      it { expect(subject).to have_attributes(name: "Ideas") }
      it { expect(subject).to respond_to(:platforms_network) }
      it { expect(subject).to respond_to(:platforms_group_members) }
    end

  end
end
