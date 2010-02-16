module Google
  module Visualization

    ##
    # = DataTable
    #
    # == Description
    #
    class DataTable < DataElement

      ##
      # Creates a new table.
      #
      def initialize(columns=[], rows=[])
        super()
        @columns = []
        @rows = []
        append_columns(columns) unless (columns.nil? or columns.empty?)
        append_rows(rows) unless (rows.nil? or rows.empty?)
      end

      ##
      # Returns the number of rows.
      #
      def rows_count
        @rows.size
      end

      ##
      # Returns the number of columns.
      #
      def columns_count
        @columns.size
      end

      ##
      # Returns the row at index.
      #
      def row(index)
        @rows[index]
      end

      ##
      # Returns the column at index.
      #
      def column(index)
        @columns[index]
      end

      ##
      # Returns the cell at index.
      #
      def cell(row_index, column_index)
        row(row_index).cell(column_index)
      end

      ##
      # Returns a enumerable of all rows.
      #
      def rows
        @rows.to_enum
      end

      ##
      # Returns a enumerable of all columns.
      #
      def columns
        @columns.to_enum
      end

      ##
      # Pushes a single row to the end of the table.
      # This expression returns the data table itself, so several appends may be
      # chained together.
      #
      def append_row(obj)
        obj = DataRow.new(obj) unless obj.is_a?(DataRow)
        raise(StandardError, "invalid size") if obj.cells_count != columns_count
        obj.close
        @rows << obj
        self
      end

      ##
      # Pushes a column to the end of the table.
      # This expression returns the data table itself, so several appends may be
      # chained together.
      #
      def append_column(obj)
        raise(StandardError, "can't modify") if rows_count > 0
        obj = DataColumn.new(obj) unless obj.is_a?(DataColumn)
        obj.close
        @columns << obj
        self
      end

      ##
      # Pushes multiple rows to the end of the table.
      # This expression returns the data table itself, so several appends may be
      # chained together.
      #
      def append_rows(list)
        list.each { |obj| append_row(obj) }
        self
      end

      ##
      # Pushes multiple columns to the end of the table.
      # This expression returns the data table itself, so several appends may be
      # chained together.
      #
      def append_columns(list)
        list.each { |obj| append_column(obj) }
        self
      end

      ##
      # Sorts the table rows according to the specified column and order.
      #
      def sort_rows!(column_index, order=:ascending)
        correlation = (order == :ascending ? 1 : -1)
        @rows.sort! { |a,b|
          (a.cell(column_index).value <=> b.cell(column_index).value) * correlation
        }
      end
      
      ##
      # Serializes data table to the specified format.
      #
      def dump(format)
        case format.to_s.downcase
        when 'json'
          Formatter::JSON.render(self)
        else
          raise(TypeError, "invalid format")
        end
      end

    end

  end
end