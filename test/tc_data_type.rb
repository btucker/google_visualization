require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataType < Test::Unit::TestCase

  def test_new
    assert_raise(NoMethodError) { DataType.new }
  end
  
  def test_constants
    assert_equal(DataType.const_defined?(:STRING), true)
    assert_equal(DataType.const_defined?(:NUMBER), true)
    assert_equal(DataType.const_defined?(:BOOLEAN), true)
    assert_equal(DataType.const_defined?(:DATE), true)
    assert_equal(DataType.const_defined?(:DATETIME), true)
    assert_equal(DataType.const_defined?(:TIMEOFDAY), true)
    assert_instance_of(DataType, DataType::STRING)
  end
  
  def test_to_s
    assert_equal(DataType::STRING.to_s, "string")
    assert_equal(DataType::NUMBER.to_s, "number")
    assert_equal(DataType::BOOLEAN.to_s, "boolean")
    assert_equal(DataType::DATE.to_s, "date")
    assert_equal(DataType::DATETIME.to_s, "datetime")
    assert_equal(DataType::TIMEOFDAY.to_s, "timeofday")
  end
  
end