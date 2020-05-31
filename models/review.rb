require_relative('../db/sql_runner')
require_relative('book')

class Review

  attr_reader :id, :book_id
  attr_accessor :rating, :review

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @book_id = options["book_id"]
    @rating = options["rating"]
    @review = options["review"]
  end

  def Review.delete_all()
    sql = "DELETE FROM reviews"
    SqlRunner.run(sql)
  end

  def Review.all()
    sql = "SELECT * FROM reviews"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|review_data| Review.new(review_data)}
  end

  def Review.find(id)
    sql = "SELECT * FROM reviews WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Review.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO reviews (book_id, rating, review) VALUES ($1, $2, $3) RETURNING *"
    values = [@book_id, @rating, @review]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM reviews WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UDPATE reviews SET (book_id, rating, review) VALUES ($1, $2, $3) WHERE id = $4"
    values = [@book_id, @rating, @review, @id]
    SqlRunner.run(sql, values)
  end

  def book()
    sql = "SELECT books.* FROM
    reviews INNER JOIN books ON reviews.book_id = books.id
    WHERE reviews.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return Book.new(pg_result[0])
  end

end
