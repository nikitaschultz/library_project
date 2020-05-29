require('minitest/autorun')
require('minitest/reporters')
require_relative('../Genre')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestGenre < MiniTest::Test
  def setup()
    @genre1 = Genre.new({"name" => "Crime"})
    @genre2 = Genre.new({"name" => "Sci-Fi"})
  end

  def test_initialize_new_genre
    assert_equal("Crime", @genre1.name())
    assert_equal("Sci-Fi", @genre2.name())
  end

end
