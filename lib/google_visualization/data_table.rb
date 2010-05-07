module Google
  module Visualization

    ##
    # = DataTable
    #
    # == Description
    #
    # Represents a two-dimensional, mutable table of values.
    #
    class DataTable < DataElement

      ##
      # Creates a new table.
      #
      def initialize(columns=[], rows=[])
        super()
        @columns = []
        @rows = []
        add_columns(columns) unless (columns.nil? or columns.empty?)
        add_rows(rows) unless (rows.nil? or rows.empty?)
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
      # Adds a single row to the end of the table and returns self.
      #
      def add_row(obj)
        obj = DataRow.new(obj) unless obj.is_a?(DataRow)
        raise(StandardError, "wrong row size #{obj.cells_count}, should be #{columns_count})") if obj.cells_count != columns_count
        obj.close
        @rows << obj
        self
      end

      ##
      # Adds a single column to the end of the table and returns self.
      #
      def add_column(obj)
        raise(StandardError, "can't add columns after adding rows") if rows_count > 0
        obj = DataColumn.new(obj) unless obj.is_a?(DataColumn)
        obj.close
        @columns << obj
        self
      end

      ##
      # Adds multiple rows to the end of the table and returns self.
      #
      def add_rows(list)
        list.each { |obj| add_row(obj) }
        self
      end

      ##
      # Adds multiple columns to the end of the table and returns self.
      #
      def add_columns(list)
        list.each { |obj| add_column(obj) }
        self
      end

      ##
      # Sorts the table rows according to the specified order and columns.
      #
      def sort_rows!(order, *columns)
        correlation = (order == :ascending ? 1 : -1)
        @rows.sort! { |a,b|
          pivot = 0
          columns.each { |column|
            pivot = column
            break if a.cell(column).value != b.cell(column).value
          }
          (a.cell(pivot).value <=> b.cell(pivot).value) * correlation          
        }
      end
      
      ##
      # Returns a JSON representation of the table, according to the Google Visualization API.
      #
      def to_json
        Formatter::JSON.render(self)
      end

      ##
      # Returns a CSV representation of the table, according to the Google Visualization API.
      #
      def to_csv
        Formatter::CSV.render(self)
      end
    end

  end
end
