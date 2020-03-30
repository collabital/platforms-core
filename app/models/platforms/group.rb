module Platforms
  # Used to define a collection of {Platforms::User}, at a level below
  # a {Platforms::Network}. This a group, community, team, etc.
  #
  # @author Benjamin Elias
  # @since 0.1.0
  class Group < ApplicationRecord

    self.table_name = "platforms_groups"

    has_many :platforms_group_members,
      class_name: "Platforms::GroupMember",
      inverse_of: :platforms_group,
      dependent: :destroy

    # A group must belong to a {Platforms::Network}
    belongs_to :platforms_network, class_name: "Platforms::Network"

    # Name, Platform ID, and {Platforms::Network} must exist
    validates :name, :platform_id, :platforms_network, presence: true

    # Platform ID is unique, for that {Platforms::Network}
    validates :platform_id, uniqueness: { scope: :platforms_network }

  end
end
