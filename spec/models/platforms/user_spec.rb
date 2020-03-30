require 'rails_helper'
require 'support/models/timestamps.rb'

module Platforms
  RSpec.describe User, type: :model do

    subject { FactoryBot.create(:user) }

    describe "traits" do
      it { expect(FactoryBot.build(:network, :alternate)).to be_valid }
    end

    describe "validations" do
      it { expect(FactoryBot.build(:user, name: "")         ).not_to be_valid }
      it { expect(FactoryBot.build(:user, email: "")        ).not_to be_valid }
      it { expect(FactoryBot.build(:user, platform_id: "")  ).not_to be_valid }
      it { expect(FactoryBot.build(:user, thumbnail_url: "")).not_to be_valid }
      it { expect(FactoryBot.build(:user, web_url: "")      ).not_to be_valid }
      it { expect(FactoryBot.build(:user, admin: nil)       ).not_to be_valid }
      it { expect(FactoryBot.build(:user, admin: true)      ).to be_valid }
      it { expect(FactoryBot.build(:user, admin: false)     ).to be_valid }

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }

        it { expect(alternate).not_to be_valid }

        it "different platform_id" do
          alternate.platform_id = "Alternate"
          expect(alternate).to be_valid
        end
      end
    end

    describe "attributes" do
      it { expect(subject).to have_attributes(name: "Joe Bloggs") }
      it { expect(subject).to have_attributes(platform_id: "10") }
      it { expect(subject).to have_attributes(thumbnail_url: "http://mypic") }
      it { expect(subject).to have_attributes(web_url: "http://myprofile") }
      it { expect(subject).to have_attributes(email: "joe@bloggs.com") }
      it { expect(subject).to have_attributes(admin: false) }

      it_behaves_like "has timestamps"

    end

    describe "#app_user" do
      let!(:app_user) { FactoryBot.create(:app_user, platforms_user_id: subject.id) }

      it { expect(subject.app_user).not_to be_nil }
      it { expect(subject.app_user).to be_a ::SampleUser }
      it { expect(subject.app_user).to eql(app_user) }
    end

    describe "#app_user configurable" do
      pending "test whether Application::User is configurable"
    end
=begin
      # This may work for User, but for some reason the same approach doesn't
      # work with Network. Do not mess with the loading, need to find another
      # way of testing this!

      # The following code works in isolation, but then it appears that
      # FactoryBot cannot use Platform::Network classes for subsequent
      # tests (e.g. Tag). So this cannot be the correct way to test this.
      subject { Platforms::User.reflect_on_association(:app_user).class_name }

      describe "dummy app's configuration" do
        it { expect(subject).to eq "SampleUser" }
      end

      describe "bespoke configuration" do
        # Save the previous configuration
        let!(:app_config) { Platforms.configuration.user_class }

        before(:each) do
          Platforms.configuration.user_class = "MyUser"
          Platforms.send(:remove_const, :User)
          load 'app/models/platforms/user.rb'
        end

        after(:each) do
          Platforms.configuration.user_class = app_config
          Platforms.send(:remove_const, :User)
          load 'app/models/platforms/user.rb'
        end

        it { expect(subject).to eq "MyUser" }
      end

      describe "check dummy app's configuration is restored" do
        it { expect(subject).to eq "SampleUser" }
      end
=end
  end
end
