require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_DataElement < Test::Unit::TestCase

  def test_new
    element = DataElement.new
    assert_not_nil(element)
    assert_instance_of(DataElement, element)
  end
  
  def test_initialize
    element = DataElement.new
    assert_equal(element.custom_properties_count, 0)
  end
  
  def test_store_custom_property
    element = DataElement.new
    element.store_custom_property('a', 0)
    assert_equal(element.custom_properties_count, 1)
    assert_equal(element.custom_property('a'), 0)
  end
  
  def test_store_custom_properties
    element = DataElement.new
    element.store_custom_properties({'a'=>0, 'b'=>1})
    assert_equal(element.custom_properties_count, 2)
    assert_equal(element.custom_property('a'), 0)
    assert_equal(element.custom_property('b'), 1)
  end

end