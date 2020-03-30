module Platforms
  # Join table between {Platforms::Group} and {Platforms::User},
  # to indicate membership.
  #
  # Includes a role, to indicate more specific membership as defined by
  # the platform.
  class GroupMember < ApplicationRecord

    self.table_name = "platforms_group_members"

    # Belongs to a {Platforms::User}
    belongs_to :platforms_user, class_name: "Platforms::User"

    # Belongs to a {Platforms::Group}
    belongs_to :platforms_group, class_name: "Platforms::Group"

    # Require valid {Platforms::User}
    validates :platforms_user, presence: true

    # Require valid {Platforms::Group}
    validates :platforms_group, presence: true

    # Require role to exist, must be in the following enum:
    # * member 0
    # * admin 1
    # * read-only 2
    validates :role, presence: true

    # Ensure [{Platforms::User}, {Platforms::Group}] keys are unique
    validates :platforms_user, uniqueness: {scope: :platforms_group}

    # Network of #platforms_user is equal to that of #platforms_group
    validate :platforms_network_match

    # Role indicates admin rights
    enum role: { member: 0, admin: 1, read_only: 2 }

    private

    # {Network} of {#platforms_user} is equal to that of #platforms_group
    #
    # Checks the {Network} of platforms_user against the {Network} of
    # platforms_group and confirms they are the same.
    def platforms_network_match
      delegated = platforms_user.platforms_network_id rescue nil
      alternate = platforms_group.platforms_network_id rescue nil

      unless delegated == alternate and !delegated.nil?
        errors.add(:network, "IDs not equal")
      end
    end

  end
end
