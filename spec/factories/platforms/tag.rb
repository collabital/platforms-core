FactoryBot.define do
  factory :tag, class: "Platforms::Tag" do
    name          { "#hashtag" }
    platform_id   { "Tag20" }

    association :platforms_network, factory: :network
  end
end
