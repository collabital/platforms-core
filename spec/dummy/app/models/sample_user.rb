class SampleUser < ApplicationRecord

  # This is by default required from Rails 5 onwards
  belongs_to :platforms_user,
    class_name: "Platforms::User",
    inverse_of: :app_user

  # Ensure User only maps to one Platforms::User
  validates :platforms_user_id, uniqueness: true
end
