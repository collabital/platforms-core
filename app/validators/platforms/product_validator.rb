module Platforms

  # Checks if a record includes an attribute with value blah, and
  # the Platforms::Blah namespace includes a class which inherits
  # from Rails::Engine. That is usually called Platforms::Blah::Engine.
  #
  # Adds a validation error if:
  # * Platforms::Blah does not exist
  # * Platforms::Blah does not have a class that inherits from Rails::Engine
  #
  class ProductValidator < ActiveModel::EachValidator

    # Validate record includes an attribute with the value of a known Engine.
    #
    # Checks if a record includes an attribute with value blah, and
    # the Platforms::Blah namespace includes a class which inherits
    # from Rails::Engine. That is usually called Platforms::Blah::Engine.
    #
    # If Platforms::Blah does not include a known Engine, add an error.
    #
    # Also requires that value is lowercase.
    #
    # @param [ActiveModel] record being validated
    # @param [Symbol] attribute name of record
    # @param [Object] value of record.attribute
    # @return no suitable return value, just adds errors to record.
    def validate_each(record, attribute, value)
      return if value.blank?

      unless value == value.downcase
        record.errors.add(attribute, "should be lower case")
        return
      end

      kamel = value.camelize

      begin
        klass = Platforms.const_get(kamel)
        children = klass.constants(false)
        children.select! do |k|
          # Do not allow non-Class looking things like String constants
          next unless klass.const_get(k).respond_to? :ancestors
          klass.const_get(k).ancestors.include? Rails::Engine
        end
        unless children.length == 1
          record.errors.add(attribute, "Platforms::#{kamel} is not a Rails::Engine")
        end
      rescue NameError => e
        record.errors.add(attribute, e)
        return
      end
    end
  end
end
