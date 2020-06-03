require('minitest/autorun')
require('minitest/reporters')
require_relative('../book')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
class TestBook < MiniTest::Test
  def setup()
    @genre1 = Genre.new({"name" => "Fantasy"})
    @genre1.save()
    @author1 = Author.new({"first_name" => "Robin", "last_name" => "Hobb"})
    @author1.save()
    @ownership_status1 = OwnershipStatus.new({"name" => "Bookshelf"})
    @ownership_status1.save()
    @readstatus1 = ReadStatus.new({"name" => "Finished"})
    @readstatus1.save()
    @format1 = Format.new({"name" => "Paperback"})
    @format1.save()
    @series1 = Series.new({"name" => "Farseer Trilogy"})
    @series1.save()
    @book1 = Book.new({
      "title" => "Assassin's Apprentice",
      "author_id" => @author1.id(),
      "genre_id" => @genre1.id(),
      "format_id" => @format.id(),
      "read_status_id" => @readstatus1.id(),
      "ownership_status_id" => @ownership_status1.id(),
      "series_id" => @series1.id(),
      "series_number" => 1
      })
    @book2 = Book.new({
      "title" => "Stand-Alone",
      "author_id" => @author1.id(),
      "genre_id" => @genre1.id(),
      "read_status_id" => @readstatus1.id(),
      "ownership_status_id" => @ownership_status1.id()
      })
  end

  def test_initialize_new_book()
    assert_equal("Assassin's Apprentice", @book1.title())
    assert_equal(1, @book1.series_number())
    assert_equal("Stand-Alone", @book2.title())
  end

end
