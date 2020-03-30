RSpec.shared_examples "has timestamps" do
  it { expect(subject).to respond_to(:created_at) }
  it { expect(subject).to respond_to(:updated_at) }
end
