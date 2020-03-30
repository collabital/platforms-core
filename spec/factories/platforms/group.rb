FactoryBot.define do
  factory :group, class: "Platforms::Group" do
    name          { "Ideas" }
    platform_id   { "Group1" }

    trait :alternate do
      name        { "Ideas Again" }
      platform_id { "Group2" }
    end

    association :platforms_network, factory: :network
  end
end
