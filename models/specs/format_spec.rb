require('minitest/autorun')
require('minitest/reporters')
require_relative('../format')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestFormat < MiniTest::Test
  def setup()
    @format1 = Format.new({"name" => "eBook"})
    @format2 = Format.new({"name" => "Paperback"})
  end

  def test_initialize_new_format
    assert_equal("eBook", @format1.name())
    assert_equal("Paperback", @format2.name())
  end

end
