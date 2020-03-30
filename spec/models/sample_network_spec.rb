require 'rails_helper'

RSpec.describe SampleNetwork, type: :model do

  subject { FactoryBot.create(:app_network) }

  describe "validations" do

    describe "uniqueness" do
      before(:each)   { subject }
      let(:alternate) { FactoryBot.build(:app_network, platforms_network: subject.platforms_network) }

      it { expect(alternate).not_to be_valid }

      describe "if different platforms_network" do
        before(:each) { alternate.platforms_network = platform_alternate }
        let(:platform_alternate) { FactoryBot.create(:network, :alternate) }

        it { expect(alternate).to be_valid }
      end

    end
  end

  describe "#platforms_network" do
    it { expect(subject.platforms_network).not_to be_nil }
    it { expect(subject.platforms_network).to be_a Platforms::Network }
    it { expect(subject.platforms_network).to be_valid }
  end

end
