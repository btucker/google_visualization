require 'csv'
require 'csv/writer'

module Google
  module Visualization
    module Formatter
      
      ##
      # = JSON Formatter
      #
      # == Description
      #
      # Serializes a DataTable to Comma Separated values (CSV)
      class CSV
        private_class_method :new
        ##
        # Generates a JSON string representation of a data table.
        #
        def self.render(data_table)
          output = ""
          CSV::Writer.generate(output) do |csv|
            csv << data_table.columns.map(&:label)
            data_table.rows.each do |row|
              csv << row.cells.map(&:value)
            end
          end
          output
        end
      end
    end
  end
end
