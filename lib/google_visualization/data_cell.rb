module Google
  module Visualization

    ##
    # = DataCell
    #
    # == Description
    #
    # Represents a single cell value in a DataTable.
    #
    class DataCell < DataElement

      ##
      # Creates a new cell.
      #
      def initialize(value=nil, formatted_value=nil)
        super()
        self.value = value
        self.formatted_value = formatted_value
      end

      ##
      # Returns the value.
      #
      def value
        @value
      end

      ##
      # Sets a value.
      #
      def value=(obj)
        @value = obj
      end

      ##
      # Returns the formatted value.
      #
      def formatted_value
        @formatted_value
      end

      ##
      # Sets a formatted value.
      #
      def formatted_value=(obj)
        @formatted_value = obj
      end

    end

  end
end