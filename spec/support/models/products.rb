RSpec.shared_examples "is a product" do |attribute|
  before(:each) do
    subject.send("#{attribute}=", attr)
  end

  describe "#{attribute} widget" do
    let(:attr) { "widget" }
    it { expect(subject).to be_valid }
  end

  describe "#{attribute} Widget" do
    let(:attr) { "Widget" }
    it { expect(subject).not_to be_valid }
  end

  describe "#{attribute} gizmo" do
    let(:attr) { "gizmo" }
    it { expect(subject).to be_valid }
  end

  describe "#{attribute} empty" do
    let(:attr) { "" }
    it { expect(subject).not_to be_valid }
  end

  describe "#{attribute} 'unknown'" do
    let(:attr) { "unknown" }
    it { expect(subject).not_to be_valid }
    it "has descriptive error on validation fail" do
      err = /uninitialized constant Platforms::Unknown/
      expect { subject.save! }.to raise_error(err)
    end
  end

  describe "#{attribute} 'contraption'" do
    let(:attr) { "contraption" }
    it { expect(subject).not_to be_valid }
    it "has descriptive error on validation fail" do
      err = /Platforms::Contraption is not a Rails::Engine/
      expect { subject.save! }.to raise_error(err)
    end
  end
end
