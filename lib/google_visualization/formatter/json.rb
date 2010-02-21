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
          result = []
          result << render_columns(data_table.columns)
          result << render_rows(data_table.rows, data_table.columns)
          if data_table.custom_properties_count > 0
            result << render_custom_properties(data_table)
          end
          "{#{result.join(',')}}"
        end

        private

        ##
        # Generates a JSON string representation of a multiple columns.
        #
        def self.render_columns(columns)
          result = columns.collect { |column|
            render_column(column)
          }
          "cols:[#{result.join(',')}]"
        end

        ##
        # Generates a JSON string representation of a single column.
        #
        def self.render_column(column)
          result = []
          unless column.id.nil?
            result << "id:#{rb_to_js(column.id, DataType::STRING)}"
          end
          unless column.label.nil?
            result << "label:#{rb_to_js(column.label, DataType::STRING)}"
          end
          result << "type:#{rb_to_js(column.type.to_s, DataType::STRING)}"
          unless column.pattern.empty?
            result << "pattern:#{rb_to_js(column.pattern, DataType::STRING)}"
          end
          if column.custom_properties_count > 0
            result << render_custom_properties(column)
          end
          "{#{result.join(',')}}"
        end

        ##
        # Generates a JSON string representation of multiple rows.
        #
        def self.render_rows(rows, columns)
          result = rows.collect { |row|
            render_row(row, columns)
          }
          "rows:[#{result.join(',')}]"
        end

        ##
        # Generates a JSON string representation of a single row.
        #
        def self.render_row(row, columns)
          result = []
          cells = columns.zip(row.cells).collect { |column, cell|
            render_cell(cell, column.type)
          }
          result << "c:[#{cells.join(',')}]"
          if row.custom_properties_count > 0
            result << render_custom_properties(row)
          end
          "{#{result.join(',')}}"
        end

        ##
        # Generates a JSON string representation of a cell.
        #
        def self.render_cell(cell, data_type)
          result = []
          result << "v:#{rb_to_js(cell.value, data_type)}"
          unless cell.formatted_value.nil?
            result << "f:#{rb_to_js(cell.formatted_value, DataType::STRING)}"
          end
          if cell.custom_properties_count > 0
            result << render_custom_properties(cell)
          end
          "{#{result.join(',')}}"
        end

        ##
        # Generates a JSON string representation of the custom properties.
        #
        def self.render_custom_properties(data_element)
          result = data_element.custom_properties.collect { |name,value|
            "#{name}:#{rb_to_js(value, DataType::STRING)}"
          }
          "p:{#{result.join(',')}}"
        end

        ##
        # Converts a Ruby value into a JavaScript value.
        #
        def self.rb_to_js(obj, type)
          return "null" if obj.nil?

          case(type)
          when DataType::STRING
            return rb_to_js_string(obj)
          when DataType::NUMBER
            return rb_to_js_number(obj)
          when DataType::BOOLEAN
            return rb_to_js_boolean(obj)
          when DataType::DATE
            return rb_to_js_date(obj)
          when DataType::DATETIME
            return rb_to_js_datetime(obj)
          when DataType::TIMEOFDAY
            return rb_to_js_timeofday(obj)
          else
            raise(TypeError, 'invalid type')
          end
        end

        ##
        # Converts a Ruby value into a JavaScript string.
        #
        def self.rb_to_js_string(obj)
          obj.to_s.inspect
        end

        ##
        # Converts a Ruby value into a JavaScript number.
        #
        def self.rb_to_js_number(obj)
          if obj.kind_of?(Integer) or obj.instance_of?(Float)
            obj.to_s
          elsif obj.respond_to?(:to_i)
            obj.to_i.to_s
          else
            raise(TypeError, "can't convert")
          end
        end

        ##
        # Converts a Ruby value into a JavaScript boolean.
        #
        def self.rb_to_js_boolean(obj)
          obj ? true.to_s : false.to_s
        end

        ##
        # Converts a Ruby value into a JavaScript date.
        #
        def self.rb_to_js_date(obj)
          if obj.instance_of?(Date) or obj.instance_of?(Time) or obj.instance_of?(DateTime)
            #Shift the month by 1 to match the JavaScript date format
            "new Date(#{obj.year},#{obj.month-1},#{obj.day})"
          else
            raise(TypeError, "can't convert")
          end
        end

        ##
        # Converts a Ruby value into a JavaScript datetime.
        #
        def self.rb_to_js_datetime(obj)
          if obj.instance_of?(Time) or obj.instance_of?(DateTime)
            #Shift the month by 1 to match the JavaScript date format
            "new Date(#{obj.year},#{obj.month-1},#{obj.day},#{obj.hour},#{obj.min},#{obj.sec})"
          else
            raise(TypeError, "can't convert")
          end
        end

        ##
        # Converts a Ruby value into a JavaScript timeofday.
        #
        def self.rb_to_js_timeofday(obj)
          if obj.instance_of?(Time) or obj.instance_of?(DateTime)
            "[#{obj.hour},#{obj.min},#{obj.sec}]"
          else
            raise(TypeError, "can't convert")
          end
        end
      end

    end
  end
end