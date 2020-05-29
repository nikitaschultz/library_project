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

  def test_save_genre
    @genre1.save()
    @genre2.save()
    assert_not_nil(@genre1.id())
    assert_not_nil(@genre2.id())
  end

  def test_genre_all
    @genre1.save()
    @genre2.save()
    assert_equal(2, Genre.all().length())
  end

  def test_delete_genre
    @genre1.save()
    @genre2.save()
    @genre1.delete()
    assert_equal(1, Genre.all().length())
  end

  def test_update_genre
    @genre1.save()
    @genre1.name = "Fantasy"
    @genre1.update
    assert_equal("Fantasy", Genre.find(@genre1.id())
  end
end
