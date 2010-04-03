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
  
  def test_add_column
    table = DataTable.new
    table.add_column(DataType::STRING)
    table.add_column(DataColumn.new(DataType::NUMBER))
    assert_equal(table.columns_count, 2)
    assert_equal(table.column(0).type, DataType::STRING)
    assert_equal(table.column(1).type, DataType::NUMBER)
  end
  
  def test_add_columns
    table = DataTable.new
    table.add_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    assert_equal(table.columns_count, 2)
    assert_equal(table.column(0).type, DataType::STRING)
    assert_equal(table.column(1).type, DataType::NUMBER)
  end
  
  def test_add_row
    table = DataTable.new
    assert_raise(StandardError) { table.add_row(['value', 0]) }
    table.add_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    table.add_row(['value', 0])
    table.add_row(DataRow.new(['value', 1]))
    assert_equal(table.rows_count, 2)
    assert_equal(table.row(0).cell(1).value, 0)
    assert_equal(table.row(1).cell(1).value, 1)
  end
  
  def test_add_rows
    table = DataTable.new
    assert_raise(StandardError) { table.add_rows([['value', 0], DataRow.new(['value', 1])]) }
    table.add_columns([DataType::STRING, DataColumn.new(DataType::NUMBER)])
    table.add_rows([['value', 0], DataRow.new(['value', 1])])
    assert_equal(table.rows_count, 2)
    assert_equal(table.row(0).cell(1).value, 0)
    assert_equal(table.row(1).cell(1).value, 1)
  end
  
  def test_close
    columns = [DataType::STRING, DataType::NUMBER]
    rows = [['value', 0], ['value', 1]]
    table = DataTable.new(columns, rows)
    assert_raise(StandardError) { table.add_column(DataColumn.new(DataType::BOOLEAN)) }
    assert_nothing_raised { table.add_row(['value', 2]) }
  end
  
  def test_sort_rows_single_column_ascending
    columns = [DataType::STRING, DataType::NUMBER]
    rows = [['value', 2], ['value', 0], ['value', 1]]
    table = DataTable.new(columns, rows)
    table.sort_rows!(:ascending, 1)
    assert_equal(table.cell(0,1).value, 0)
    assert_equal(table.cell(1,1).value, 1)
    assert_equal(table.cell(2,1).value, 2)
  end
  
  def test_sort_rows_single_column_descending
    columns = [DataType::STRING, DataType::NUMBER]
    rows = [['value', 2], ['value', 0], ['value', 1]]
    table = DataTable.new(columns, rows)
    table.sort_rows!(:descending, 1)
    assert_equal(table.cell(0,1).value, 2)
    assert_equal(table.cell(1,1).value, 1)
    assert_equal(table.cell(2,1).value, 0)
  end
 
  def test_sort_rows_multiple_columns_ascending
    columns = [DataType::STRING, DataType::NUMBER, DataType::NUMBER]
    rows = [['d', 2, 0], ['b', 1, 1], ['a', 1, 2], ['c', 0, 3]]
    table = DataTable.new(columns, rows)
    table.sort_rows!(:ascending, 1, 2)
    assert_equal(table.cell(0,0).value, 'c')
    assert_equal(table.cell(1,0).value, 'b')
    assert_equal(table.cell(2,0).value, 'a')
    assert_equal(table.cell(3,0).value, 'd')
  end
  
  def test_sort_rows_multiple_columns_descending
    columns = [DataType::STRING, DataType::NUMBER, DataType::NUMBER]
    rows = [['d', 2, 0], ['b', 1, 1], ['a', 1, 2], ['c', 0, 3]]
    table = DataTable.new(columns, rows)
    table.sort_rows!(:descending, 1, 2)
    assert_equal(table.cell(0,0).value, 'd')
    assert_equal(table.cell(1,0).value, 'a')
    assert_equal(table.cell(2,0).value, 'b')
    assert_equal(table.cell(3,0).value, 'c')
  end

  def test_custom_properties
    table = DataTable.new
    assert_equal(table.is_a?(DataElement), true)
  end

end