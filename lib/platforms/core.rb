require "platforms/core/app_network"
require "platforms/core/app_user"
require "platforms/core/configuration"
require "platforms/core/engine"
require "platforms/core/omni_auth_setup"
require "platforms/core/o_auth_2"

require "generators/platforms/core/install/install_generator"

# The top level namespace for Platforms, which includes Core and
# other vendor-specific implementations.
module Platforms
  # Common functionality across all Platforms should go in the Core module.
  #
  # That includes minimal storage of external data, which should of course
  # be limited to ensure ongoing consistency. For example, Yammer has the
  # concept of a hashtag, even though Teams does not. The representation
  # sits in Platforms::Core (not Platforms::Yammer) as it is replicating
  # an external data object.
  module Core
  end
end
