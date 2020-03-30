FactoryBot.define do
  factory :app_network, class: "SampleNetwork"  do
    association :platforms_network, factory: :network
  end
end
