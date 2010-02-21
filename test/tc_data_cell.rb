require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataCell < Test::Unit::TestCase
  
  def test_new
    cell = DataCell.new
    assert_not_nil(cell)
    assert_instance_of(DataCell, cell)
  end
  
  def test_initialize_empty
    cell = DataCell.new
    assert_equal(cell.value, nil)
    assert_equal(cell.formatted_value, nil)
  end
  
  def test_initialize_value
    cell = DataCell.new('value')
    assert_equal(cell.value, 'value')
  end
  
  def test_initialize_formatted_value
    cell = DataCell.new(nil,'formatted_value')
    assert_equal(cell.formatted_value, 'formatted_value')
  end
  
  def test_accessor_value
    cell = DataCell.new
    cell.value = 'value'
    assert_equal(cell.value, 'value')
  end
  
  def test_accessor_formatted_value
    cell = DataCell.new
    cell.formatted_value = 'formatted_value'
    assert_equal(cell.formatted_value, 'formatted_value')
  end
  
  def test_custom_properties
    cell = DataCell.new
    assert_equal(cell.is_a?(DataElement), true)
  end

end