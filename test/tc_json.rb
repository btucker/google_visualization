require 'time'
require 'date'
require File.join(File.dirname(__FILE__), 'helper.rb')

class TC_JSON < Test::Unit::TestCase

  def setup
    Formatter::JSON.public_class_method(:rb_to_js)
  end
  
  def test_new
    assert_raise(NoMethodError) { Formatter::JSON.new }
  end

  def test_rb_to_js_null
    assert_equal("null", Formatter::JSON.rb_to_js(nil, nil))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::STRING))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::NUMBER))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::BOOLEAN))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::DATE))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::DATETIME))
    assert_equal("null", Formatter::JSON.rb_to_js(nil, DataType::TIMEOFDAY))
  end

  def test_rb_to_js_string
    strings = ["regular", "new\nline", "single'quote", 'double"quote', "one\slash", "two\\slash"]
    strings.each { |expression|
      assert_equal(expression, eval(Formatter::JSON.rb_to_js(expression, DataType::STRING)))
    }
    assert_equal("\"1\"", Formatter::JSON.rb_to_js(1, DataType::STRING))
    assert_equal("\"true\"", Formatter::JSON.rb_to_js(true, DataType::STRING))
  end

  def test_rb_to_js_number
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(true, DataType::NUMBER) }
    assert_equal("1", Formatter::JSON.rb_to_js(1, DataType::NUMBER))
    assert_equal("1.0",	Formatter::JSON.rb_to_js(1.0, DataType::NUMBER))
    assert_equal("-1", Formatter::JSON.rb_to_js(-1, DataType::NUMBER))
    assert_equal("1", Formatter::JSON.rb_to_js("1", DataType::NUMBER))
    assert_equal("0", Formatter::JSON.rb_to_js("abc", DataType::NUMBER))
  end

  def test_rb_to_js_boolean
    assert_equal("false", Formatter::JSON.rb_to_js(false, DataType::BOOLEAN))
    assert_equal("true", Formatter::JSON.rb_to_js(true, DataType::BOOLEAN))
    assert_equal("true", Formatter::JSON.rb_to_js(0, DataType::BOOLEAN))
    assert_equal("true", Formatter::JSON.rb_to_js(1, DataType::BOOLEAN))
    assert_equal("true", Formatter::JSON.rb_to_js("abc", DataType::BOOLEAN))
  end

  def test_rb_to_js_date
    d = Date.parse("2000/01/02 03:04:05")
    t = Time.parse("2000/01/02 03:04:05")
    dt = DateTime.parse("2000/01/02 03:04:05")
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(0, DataType::DATE) }
    assert_equal("new Date(2000,0,2)", Formatter::JSON.rb_to_js(d, DataType::DATE))
    assert_equal("new Date(2000,0,2)", Formatter::JSON.rb_to_js(t, DataType::DATE))
    assert_equal("new Date(2000,0,2)", Formatter::JSON.rb_to_js(dt, DataType::DATE))
  end

  def test_rb_to_js_datetime
    d = Date.parse("2000/01/02 03:04:05")
    t = Time.parse("2000/01/02 03:04:05")
    dt = DateTime.parse("2000/01/02 03:04:05")
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(0, DataType::DATETIME) }
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(d, DataType::DATETIME) }
    assert_equal("new Date(2000,0,2,3,4,5)", Formatter::JSON.rb_to_js(t, DataType::DATETIME))
    assert_equal("new Date(2000,0,2,3,4,5)", Formatter::JSON.rb_to_js(dt, DataType::DATETIME))
  end

  def test_rb_to_js_timeofday
    d = Date.parse("2000/01/02 03:04:05")
    t = Time.parse("2000/01/02 03:04:05")
    dt = DateTime.parse("2000/01/02 03:04:05")
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(0, DataType::TIMEOFDAY) }
    assert_raise(TypeError) { Formatter::JSON.rb_to_js(d, DataType::DATETIME) }
    assert_equal("[3,4,5]", Formatter::JSON.rb_to_js(t, DataType::TIMEOFDAY))
    assert_equal("[3,4,5]", Formatter::JSON.rb_to_js(dt, DataType::TIMEOFDAY))
  end
  
  def test_render
    ruby_files = Dir.glob("test/data/*.rb")
    json_files = Dir.glob("test/data/*json")
    ruby_files.zip(json_files).each { |ruby_file, json_file|
      table = eval(File.new(ruby_file).read)
      assert_equal(Formatter::JSON.render(table), File.new(json_file).read)
    }
  end

end