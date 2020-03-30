module Platforms
  # The basic network concept for a platform. Users are grouped together on
  # within an information boundary. Could be a 'tenant'.
  class Network < ApplicationRecord

    self.table_name = "platforms_networks"

    # Has a Network from the parent app
    has_one :app_network,
      class_name: Platforms::Core.configuration.network_class,
      foreign_key: "platforms_network_id"

    # {Platforms::Group} belong to this network
    has_many :platforms_groups, class_name: "Platforms::Group"

    # {Platforms::User} belong to this network
    has_many :platforms_users,  class_name: "Platforms::User"

    # {Platforms::Tag} belong to this network
    has_many :platforms_tags,   class_name: "Platforms::Tag"

    # Name of a network must exist.
    validates :name, presence: true

    # Permalink of the network must exist. Mostly for Yammer, but
    # also applicable to Office 365. Should default to name if
    # no concept is defined by the platform.
    validates :permalink, presence: true

    # Must have a platform type, which is effectively the Engine
    # that the network should authenticated against.
    validates :platform_type, presence: true

    # Do not require app_network to exist, as that is created after
    # Do not require certificate to exist, as the Certificate may not be
    # saved in the database (if it is the default).

    # Platform exists and is unique for each platform
    validates :platform_id,
      presence: true,
      uniqueness: { scope: :platform_type }

    # Trial exists as boolean
    validates :trial, inclusion: { in: [true, false] }

    # Platform is known (can be extended if the Platforms::NewProduct exists)
    validates :platform_type, 'platforms/product' => true
  end
end
