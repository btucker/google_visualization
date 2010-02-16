require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataTable < Test::Unit::TestCase
  
  def test_new
    table = DataTable.new
    assert_not_nil(table)
    assert_instance_of(DataTable, table)
  end
  
  def test_initialize_empty
    table = DataTable.new
    assert_equal(table.columns_count, 0)
    assert_equal(table.rows_count, 0)
  end
  
  def test_initialize_columns
    columns = [DataType::STRING, DataColumn.new(DataType::NUMBER)]
    table = DataTable.new(columns)
    assert_equal(table.columns_count, 2)
  end
  
  def test_initialize_rows
    columns = [DataType::STRING, DataColumn.new(DataType::NUMBER)]
    rows = [['value', 0], DataRow.new(['value', 1])]
    assert_raise(StandardError) { DataTable.new(nil, rows) }
    table = DataTable.new(columns, rows)
    assert_equal(table.rows_count, 2)
  end
  
  def test_append_column
    table = DataTable.new
    table.append_column(DataType::STRING)
    table.append_column(DataColumn.new(DataType::NUMBER))
    assert_equal(table.columns_count, 2)
    assert_equal(table.column(0).type, DataType::STRING)
    assert_equal(table.column(1).type, DataType::NUMBER)
  end
  
  def test_append_columns
    table = DataTable.new
    table.append_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    assert_equal(table.columns_count, 2)
    assert_equal(table.column(0).type, DataType::STRING)
    assert_equal(table.column(1).type, DataType::NUMBER)
  end
  
  def test_append_row
    table = DataTable.new
    assert_raise(StandardError) { table.append_row(['value', 0]) }
    table.append_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    table.append_row(['value', 0])
    table.append_row(DataRow.new(['value', 1]))
    assert_equal(table.rows_count, 2)
    assert_equal(table.row(0).cell(1).value, 0)
    assert_equal(table.row(1).cell(1).value, 1)
  end
  
  def test_append_rows
    table = DataTable.new
    assert_raise(StandardError) { table.append_rows([['value', 0], DataRow.new(['value', 1])]) }
    table.append_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    table.append_rows([['value', 0], DataRow.new(['value', 1])])
    assert_equal(table.rows_count, 2)
    assert_equal(table.row(0).cell(1).value, 0)
    assert_equal(table.row(1).cell(1).value, 1)
  end
  
  def test_close
    columns = [DataType::STRING, DataColumn.new(DataType::NUMBER)]
    rows = [['value', 0], DataRow.new(['value', 1])]
    table = DataTable.new(columns, rows)
    assert_raise(StandardError) { table.append_column(DataColumn.new(DataType::BOOLEAN)) }
    assert_nothing_raised { table.append_row(['value', 2]) }
  end
  
  def test_sort_rows_ascending
    columns = [DataType::STRING, DataColumn.new(DataType::NUMBER)]
    rows = [['value', 2], ['value', 0], DataRow.new(['value', 1])]
    table = DataTable.new(columns, rows)
    table.sort_rows!(1, :ascending)
    assert_equal(table.cell(0,1).value, 0)
    assert_equal(table.cell(1,1).value, 1)
    assert_equal(table.cell(2,1).value, 2)
  end
  
  def test_sort_rows_descending
    columns = [DataType::STRING, DataColumn.new(DataType::NUMBER)]
    rows = [['value', 2], ['value', 0], DataRow.new(['value', 1])]
    table = DataTable.new(columns, rows)
    table.sort_rows!(1, :descending)
    assert_equal(table.cell(0,1).value, 2)
    assert_equal(table.cell(1,1).value, 1)
    assert_equal(table.cell(2,1).value, 0)
  end
  
  def test_custom_properties
    table = DataTable.new
    assert_equal(table.is_a?(DataElement), true)
  end

end