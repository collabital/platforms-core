module Platforms
  module Core
    # Add the relevant associations to a User-type class.
    module AppUser
      extend ActiveSupport::Concern

      included do
        # A valid association object is required from Rails 5 onwards,
        # unless otherwise specified.
        belongs_to :platforms_user,
          class_name: "Platforms::User",
          inverse_of: :app_user

        # Ensure AppUser only maps to one Platforms::User
        validates :platforms_user_id, uniqueness: true
      end
    end
  end
end
