require 'rails_helper'
require 'support/models/timestamps.rb'

module Platforms
  RSpec.describe GroupMember, type: :model do
    let(:user)  { FactoryBot.create(:user)  }
    let(:group) { FactoryBot.create(:group, platforms_network: user.platforms_network) }

    subject { FactoryBot.create(:group_member, platforms_user: user, platforms_group: group) }

    it { expect(subject).to be_valid }

    it_behaves_like "has timestamps"

    describe "validations" do
      it { expect(FactoryBot.build(:group_member, platforms_user: nil)).not_to be_valid }
      it { expect(FactoryBot.build(:group_member, platforms_group: nil)).not_to be_valid }
      it "role = nil" do
        subject.role = nil
        expect(subject).not_to be_valid
      end

      it "role = member" do
        subject.role = "member"
        expect(subject).to be_valid
      end

      it "role = admin" do
        subject.role = "member"
        expect(subject).to be_valid
      end

      it "role = read_only" do
        subject.role = "read_only"
        expect(subject).to be_valid
      end

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }

        it { expect(alternate).not_to be_valid }

        it "different platforms_group" do
          group = FactoryBot.create(:group, :alternate, platforms_network: user.platforms_network)
          alternate.platforms_group = group
          expect(alternate).to be_valid
        end
      end
    end

    describe "attributes" do
      it { expect(subject).to have_attributes(role: "member") }
      it { expect(subject).to respond_to(:platforms_group) }
      it { expect(subject).to respond_to(:platforms_user) }
    end

    describe "relationships" do
      before :each do
        subject
      end
      it { expect(user.platforms_group_members.count).to eq 1 }
      it { expect(group.platforms_group_members.count).to eq 1 }
    end
  end
end
