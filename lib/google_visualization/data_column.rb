module Google
  module Visualization

    ##
    # = DataColumn
    #
    # == Description
    #
    # Represents the schema of a column in a DataTable.
    #
    class DataColumn < DataElement

      ##
      # Creates a new column.
      #
      def initialize(type=nil, label=nil, id=nil)
        super()
        @closed = false
        self.id = id
        self.type = type || DataType::STRING
        self.label = label
        self.pattern = nil
      end

      ##
      # Returns the id.
      #
      def id
        @id
      end

      ##
      # Sets a id.
      #
      def id=(obj)
        @id = obj
      end

      ##
      # Returns the type.
      #
      def type
        @type
      end

      ##
      # Sets a type.
      #
      def type=(obj)
        raise(StandardError, "can't modify") if @closed
        raise(TypeError, "invalid type") unless obj.is_a?(DataType)
        @type = obj
      end

      ##
      # Returns the label.
      #
      def label
        @label
      end

      ##
      # Sets a type.
      #
      def label=(obj)
        @label = obj
      end

      ##
      # Returns the pattern.
      #
      def pattern
        @pattern
      end

      ##
      # Sets a pattern.
      #
      def pattern=(obj)
        @pattern = obj
      end

      ##
      # Prevents the type from being altered.
      #
      def close
        @closed = true
      end

      ##
      # Returns true if closed.
      #
      def closed?
        @closed
      end

    end

  end
end