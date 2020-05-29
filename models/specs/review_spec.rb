require('minitest/autorun')
require('minitest/reporters')
require_relative('../Review')
require_relative('../Book')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
class TestReview < MiniTest::Test
  def setup()
    @genre1 = Genre.new({"name" => "Fantasy"})
    @genre1.save()
    @author1 = Author.new({"first_name" => "Robin", "last_name" => "Hobb"})
    @author1.save()
    @ownership_status1 = OwnershipStatus.new({"name" => "Bookshelf"})
    @ownership_status1.save()
    @readstatus1 = ReadStatus.new({"name" => "Finished"})
    @readstatus1.save()
    @series1 = Series.new({"name" => "Farseer Trilogy"})
    @series1.save()
    @book1 = Book.new({
      "title" => "Assassin's Apprentice",
      "author_id" => @author1.id(),
      "genre_id" => @genre1.id(),
      "read_status_id" => @readstatus1.id(),
      "ownership_status_id" => @ownership_status1.id(),
      "series_id" => @series1.id(),
      "series_number" => 1
      })
    @book1.save()
    @review1 = Review.new({"book_id" => @book1.id(),
      "rating" => 4, "review" => "Great read."})
  end

  def test_initialize_new_review
    assert_equal(4, @review1.rating())
    assert_equal("Great read.", @review1.review())
  end

end
