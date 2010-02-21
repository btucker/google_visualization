require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataColumn < Test::Unit::TestCase
  
  def test_new
    column = DataColumn.new
    assert_not_nil(column)
    assert_instance_of(DataColumn, column)
  end
  
  def test_initialize_empty
    column = DataColumn.new
    assert_equal(column.id, nil)
    assert_equal(column.type, DataType::STRING)
    assert_equal(column.label, nil)
    assert_equal(column.pattern, "")
    assert_equal(column.closed?, false)
  end
  
  def test_initialize_type
    column = DataColumn.new(DataType::NUMBER)
    assert_equal(column.type, DataType::NUMBER)
    assert_raise(TypeError) { DataColumn.new(:STRING) }
  end
  
  def test_initialize_label
    column = DataColumn.new(nil, 'label')
    assert_equal(column.label, 'label')
  end
  
  def test_initialize_id
    column = DataColumn.new(nil, nil, 'id')
    assert_equal(column.id, 'id')
  end
  
  def test_accessor_id
    column = DataColumn.new
    column.id = 'id'
    assert_equal(column.id, 'id')
  end
  
  def test_accessor_type
    column = DataColumn.new
    column.type = DataType::NUMBER
    assert_equal(column.type, DataType::NUMBER)
    assert_raise(TypeError) { column.type = :STRING }
  end
  
  def test_accessor_label
    column = DataColumn.new
    column.label = 'label'
    assert_equal(column.label, 'label')
  end
  
  def test_accessor_pattern
    column = DataColumn.new
    column.pattern = 'pattern'
    assert_equal(column.pattern, 'pattern')
  end
  
  def test_close
    column = DataColumn.new
    column.close
    assert_equal(column.closed?, true)
    assert_raise(StandardError) { column.type = DataType::NUMBER }
    assert_nothing_raised { column.id = 'id' }
    assert_nothing_raised { column.label = 'label' }
    assert_nothing_raised { column.pattern = 'pattern' }
  end
  
  def test_custom_properties
    column = DataColumn.new
    assert_equal(column.is_a?(DataElement), true)
  end

end