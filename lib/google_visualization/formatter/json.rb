require 'json'

module Google
  module Visualization
    module Formatter

      ##
      # = JSON Formatter
      #
      # == Description
      #
      # Serializes a DataTable to the JavaScript Object Notation (JSON).
      #
      class JSON

        private_class_method :new

        ##
        # Generates a JSON string representation of a data table.
        #
        def self.render(data_table)
          {
              'cols' => render_columns(data_table),
              'rows' => render_rows(data_table) #,
              #            'p' => render_custom_properties(data_table)
          }.to_json
        end

        private

        ##
        # Generates a JSON string representation of a multiple columns.
        #
        def self.render_columns(data_table)
          data_table.columns.map{|c| render_column(c)}
        end

        ##
        # Generates a JSON string representation of a single column.
        #
        def self.render_column(column)
          result = {}
          %w(id label type pattern).each do |field|
            result[field] = column.send(field).to_s if column.send(field)
          end
          # if column.custom_properties_count > 0
          #   result["p"] = render_custom_properties(column)
          # end
          result
        end

        ##
        # Generates a JSON string representation of multiple rows.
        #
        def self.render_rows(data_table)
          data_table.rows.map{|r| render_row(r, data_table)}
        end

        ##
        # Generates a JSON string representation of a single row.
        #
        def self.render_row(row, data_table)
          result = {'c' => []}
          i = 0
          result = {'c' => row.cells.map { |c|
            c = render_cell(c, data_table.column(i).type)
            i+=1
            c
          }
          }

          result
        end
        ##
        # Generates a JSON string representation of a cell.
        #
        def self.render_cell(cell, type=nil)

          if (type == DataType::DATETIME || type == DataType::DATE)
            d = cell.value
            if d.instance_of?(Date)
              result = { 'v'  => "Date(#{d.year}, #{d.month}, #{d.day})"}
            elsif d.instance_of?(DateTime)
              result = { 'v'  => "Date(#{d.year}, #{d.month}, #{d.day}, #{d.hour}, #{d.minute}, #{d.second})"}
            end
          else
            result = {'v' => cell.value}
            result['f'] = cell.formatted_value if cell.formatted_value
            # result['p'] = render_custom_properties(row) if row.custom_properties_count > 0
          end

          result
        end

        ##
        # Generates a JSON string representation of the custom properties.
        #
        #def self.render_custom_properties(data_element)
        #  result = data_element.custom_properties.collect { |name,value|
        #    "#{name.to_s}:#{rb_to_js(value, DataType::STRING)}"
        #  }
        #  "p:{#{result.join(',')}}"
        #end
      end
    end
  end
end
