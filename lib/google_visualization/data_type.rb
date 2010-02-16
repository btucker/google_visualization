module Google
  module Visualization

    ##
    # = DataType
    #
    # == Description
    #
    # Represents a data type for a DataColumn.
    #
    class DataType

      ##
      # Creates a new type.
      #
      def initialize(name)
        @name = name
      end

      ##
      # Returns a string representing the type.
      #
      def to_s
        @name.to_s
      end

      STRING = DataType.new(:string)
      NUMBER = DataType.new(:number)
      BOOLEAN = DataType.new(:boolean)
      DATE = DataType.new(:date)
      DATETIME = DataType.new(:datetime)
      TIMEOFDAY = DataType.new(:timeofday)

      private_class_method :new
    end

  end
end