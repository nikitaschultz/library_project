require('minitest/autorun')
require('minitest/reporters')
require_relative('../Author')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestAuthor < MiniTest::Test
  def setup()
    @author1 = Author.new("first_name" => "Patrick", "last_name" => "Rothfuss")
    @author2 = Author.new("first_name" => "Markus", "last_name" => "Zusak")
  end

  def test_initialize_new_author
    assert_equal("Patrick", @author1.first_name)
    assert_equal("Rothfuss", @author1.last_name)
    assert_equal("Markus", @author2.first_name)
    assert_equal("Zusak", @author2.last_name)
  end

  def test_print_full_name
    assert_equal("Patrick Rothfuss", @author1.full_name)
    assert_equal("Markus Zusak", @author2.full_name)
  end
end
