require('minitest/autorun')
require('minitest/reporters')
require_relative('../tag')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestTag < MiniTest::Test
  def setup()
    @tag1 = Tag.new("name" => "Page-turner")
    @tag2 = Tag.new("name" => "Twisty")
  end

  def test_initialize_new_tag
    assert_equal("Page-turner", @tag1.name())
    assert_equal("Twisty", @tag2.name())
  end
end
