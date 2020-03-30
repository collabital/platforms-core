FactoryBot.define do
  factory :app_user, class: "SampleUser"  do
    association :platforms_user, factory: :user
  end
end
