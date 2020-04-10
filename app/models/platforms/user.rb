module Platforms
  # A User in a {Platforms::Network}. Serves the purpose of a colleague,
  # but also for authentication identity.
  class User < ApplicationRecord

    self.table_name = "platforms_users"

    # Has a User from the parent app
    # Do not require parent app's User to exist, as that is created after.
    has_one :app_user,
      class_name: Platforms::Core.configuration.user_class,
      foreign_key: "platforms_user_id"

    # Belongs to a {Platforms::Network}
    belongs_to :platforms_network,
      class_name: "Platforms::Network"

    # Links to Groups through {Platforms::GroupMember}.
    has_many :platforms_group_members,
      class_name: "Platforms::GroupMember",
      inverse_of: :platforms_user,
      foreign_key: :platforms_user_id,
      dependent: :destroy

    # Name must exist for display
    validates :name, presence: true

    # An identifier on the platform, does not have to be numeric.
    validates :platform_id, presence: true

    # The user's thumbnail photo as a URL
    validates :thumbnail_url, presence: true

    # A URL related to the user
    validates :web_url, presence: true

    # Must have some contact details
    validates :email, presence: true

    # Has a related {Platforms::Network}
    validates :platforms_network, presence: true

    # Platform ID must be unique
    validates :platform_id, uniqueness: { scope: :platforms_network_id }

    # Must record whether the user is an admin on the platform
    validates :admin, inclusion: { in: [true, false] }

  end
end
