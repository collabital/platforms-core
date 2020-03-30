module Platforms
  # A Tag within a {Platforms::Network}. Typically a hashtag or similar,
  # which may not be used in some platforms.
  class Tag < ApplicationRecord
    include Twitter::TwitterText::Extractor

    self.table_name = "platforms_tags"

    # Do not use the same strategy as Network/User here
    # as a Platforms::Tag does not need to has_one (or has_many)
    # Application-level tags.

    # Belongs to a {Platforms::Network}
    belongs_to :platforms_network, class_name: "Platforms::Network"

    # Must have an identifying name
    validates :name, presence: true

    # The {Platforms::Network} must exist
    validates :platforms_network, presence: true

    # Does not need to validate platform_id, as it could be nil on
    # the first insert (when creating it as part of some content, for example)

    # platform_id is unique to the {Platforms::Network}. Should be able to have
    # the same tag on different Networks, and not cause validation errors.
    validates :platform_id,
      uniqueness: {scope: :platforms_network},
      allow_nil: true

    # name is unique to the {Platforms::Network}. Should be able to have
    # the same tag on different Networks, and not cause validation errors.
    validates :name,
      uniqueness: {scope: :platforms_network},
      allow_nil: true

    # Hashtag syntax is actually quite complicated. Stick to Twitter rules.
    validate :tag_syntax

    # Minimum of 2 characters (including "#")
    validates :name, length: {minimum: 2}

    private
    def tag_syntax
      expected = [self.name.sub(/\A#/, '')]
      errors.add(:name, :format_hashtag) unless \
        extract_hashtags(name) == expected
    end

  end
end
