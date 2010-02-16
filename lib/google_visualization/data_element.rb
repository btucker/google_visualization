module Google
  module Visualization

    ##
    # = DataElement
    #
    # == Description
    #
    class DataElement

      ##
      # Creates a new data element.
      #
      def initialize
        @custom_properties = {}
      end

      ##
      # Returns the number of custom properties.
      #
      def custom_properties_count
        @custom_properties.size
      end

      ##
      # Returns the value of a named property, or nil if no such property is
      # set.
      #
      def custom_property(name)
        @custom_properties[name]
      end

      ##
      # Returns a enumerable of all properties.
      #
      def custom_properties
        @custom_properties.to_enum
      end

      ##
      # Sets a single property.
      #
      def store_custom_property(name, value)
        @custom_properties[name] = value
      end

      ##
      # Sets multiple properties.
      #
      def store_custom_properties(hash)
        @custom_properties.merge!(hash)
      end

    end

  end
end