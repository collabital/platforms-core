require 'rails_helper'
require 'support/models/timestamps.rb'
require 'support/models/products.rb'

module Platforms
  RSpec.describe Certificate, type: :model do

    subject { FactoryBot.create(:certificate) }

    it { expect(subject).to be_valid }

    it_behaves_like "has timestamps"
    it_behaves_like "is a product", :strategy

    describe "validations" do
      it { expect(FactoryBot.build(:certificate, client_id: "")).not_to be_valid }
      it { expect(FactoryBot.build(:certificate, client_secret: "")).not_to be_valid }
      it { expect(FactoryBot.build(:certificate, name: "")).not_to be_valid }

      describe "uniqueness" do
        before(:each)   { subject }
        let(:alternate) { subject.dup }
        it { expect(alternate).not_to be_valid }
        it "different name" do
          alternate.name = "Alternate"
          expect(alternate).to be_valid
        end
      end
    end

    describe "attributes" do
      it { expect(subject).to have_attributes(client_id: "OAuthClientId") }
      it { expect(subject).to have_attributes(client_secret: "OAuthClientSecret") }
      it { expect(subject).to have_attributes(name: "Contoso") }

      it { expect(subject).to respond_to :client_secret_privacy }
      it { expect(subject).to respond_to :credentials }
    end

    describe "#client_secret_privacy" do
      let(:cert) { FactoryBot.build(:certificate, client_secret: secret) }
      subject { cert.client_secret_privacy }

      describe "client_secret nil" do
        let(:secret) { nil }
        it { expect(subject).to be_nil }
      end

      describe "client_secret short" do
        let(:secret) { "123456789" }
        it { expect(subject).to eq "*****" }
      end

      describe "client_secret long" do
        let(:secret) { "12345678910" }
        it { expect(subject).to eq "*****910" }
      end
    end

    describe "#credentials" do
      let(:credentials) do
        {
          client_id:     "OAuthClientId",
          client_secret: "OAuthClientSecret"
        }
      end
      it { expect(subject.credentials).to be_a Hash }
      it { expect(subject.credentials).to eq credentials }
    end
  end
end
