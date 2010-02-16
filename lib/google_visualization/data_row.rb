module Google
  module Visualization

    ##
    # = DataRow
    #
    # == Description
    #
    # Represents a row of data in a DataTable.
    #
    class DataRow < DataElement

      ##
      # Creates a new row.
      #
      def initialize(cells=[])
        super()
        @closed = false
        @cells = []
        add_cells(cells) unless (cells.nil? or cells.empty?)
      end

      ##
      # Returns the number of cells.
      #
      def cells_count
        @cells.size
      end

      ##
      # Returns the cell at index.
      #
      def cell(index)
        @cells[index]
      end

      ##
      # Returns a enumerable of all cells.
      #
      def cells
        @cells.to_enum
      end

      ##
      # Adds a single object to the end of the row and returns self.
      #
      def add_cell(obj)
        raise(StandardError, "can't modify") if @closed
        obj = DataCell.new(obj) unless obj.is_a?(DataCell)
        @cells << obj
        self
      end

      ##
      # Adds multiple objects to the end of the row and returns self.
      #
      def add_cells(list)
        list.each { |obj| add_cell(obj) }
        self
      end

      ##
      # Prevents new cells from being added.
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