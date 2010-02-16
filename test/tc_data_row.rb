require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataRow < Test::Unit::TestCase
  
  def test_new
    row = DataRow.new
    assert_not_nil(row)
    assert_instance_of(DataRow, row)
  end
  
  def test_initialize_empty
    row = DataRow.new
    assert_equal(row.cells_count, 0)
    assert_equal(row.closed?, false)
  end
  
  def test_initialize_cells
    row = DataRow.new(['value', DataCell.new(0)])
    assert_equal(row.cells_count, 2)
  end
  
  def test_append_cell
    row = DataRow.new
    row.append_cell('value')
    row.append_cell(DataCell.new(0))
    assert_equal(row.cell(0).value, 'value')
    assert_equal(row.cell(1).value, 0)
  end
  
  def test_append_cells
    row = DataRow.new
    row.append_cells(['value', DataCell.new(0)])
    assert_equal(row.cell(0).value, 'value')
    assert_equal(row.cell(1).value, 0)
  end
  
  def test_close
    row = DataRow.new
    row.close
    assert_equal(row.closed?, true)
    assert_raise(StandardError) { row.append_cell('value') }
  end
  
  def test_custom_properties
    row = DataRow.new
    assert_equal(row.is_a?(DataElement), true)
  end

end