FactoryBot.define do
  factory :network, class: "Platforms::Network" do
    name          { "Acme" }
    permalink     { "acme-com" }
    platform_id   { "1" }
    platform_type { "widget" }
    trial         { false }

    trait :alternate do
      platform_id { "2" }
    end
  end
end
