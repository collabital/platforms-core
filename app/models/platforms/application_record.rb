module Platforms
  # An abstract class for the Platform models to inherit from
  # Note that these are not namespaced to Platforms::Core, for
  # convenience of the Engine's parent application.
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
