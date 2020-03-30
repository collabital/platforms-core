require 'rails_helper'

RSpec.describe SampleUser, type: :model do

  subject { FactoryBot.create(:app_user) }

  describe "validations" do

    describe "uniqueness" do
      before(:each)   { subject }
      let(:alternate) { FactoryBot.build(:app_user, platforms_user: subject.platforms_user) }

      it { expect(alternate).not_to be_valid }

      describe "if different platforms_user" do
        let(:platforms_network) { subject.platforms_user.platforms_network }
        let(:platforms_alt)     { FactoryBot.create(:user, :alternate, platforms_network: platforms_network) }
        before(:each) { alternate.platforms_user = platforms_alt }

        it { expect(alternate).to be_valid }
      end

    end
  end

  describe "#platforms_user" do
    it { expect(subject.platforms_user).not_to be_nil }
    it { expect(subject.platforms_user).to be_a Platforms::User }
    it { expect(subject.platforms_user).to be_valid }
  end

end
