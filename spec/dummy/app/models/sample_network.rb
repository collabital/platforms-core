class SampleNetwork < ApplicationRecord

  # This is by default required from Rails 5 onwards
  belongs_to :platforms_network,
    class_name: "Platforms::Network",
    inverse_of: :app_network

  # Ensure Network only maps to one Platforms::Network
  validates :platforms_network_id, uniqueness: true
end
