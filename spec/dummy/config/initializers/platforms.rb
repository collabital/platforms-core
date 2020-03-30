# This changes the default class names for Network and User

# Necessary because Dummy-specific classes which imitate other gems
# like platforms-yammer or platforms-teams need to be loaded before
# the Platforms configuration. These are Widget, Gizmo, and Contraption.
require "#{Rails.root}/lib/platforms_extensions.rb"

Platforms::Core.configure do |config|
  config.network_class = "SampleNetwork"
  config.user_class    = "SampleUser"
end
