require_relative('../db/sql_runner')
require_relative('book')
require_relative('tag')

class BookTag

  attr_reader :id
  attr_accessor :book_id, :tag_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @book_id = options["book_id"]
    @tag_id = options["tag_id"]
  end

  def BookTag.delete_all()
    sql = "DELETE FROM books_tags"
    SqlRunner.run(sql)
  end

  def BookTag.all()
    sql = "SELECT * FROM books_tags"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|book_tag_info| BookTag.new(book_tag_info)}
  end

  def BookTag.find(id)
    sql = "SELECT * FROM books_tags WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return BookTag.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO books_tags (book_id, tag_id) VALUES ($1, $2) RETURNING *"
    values = [@book_id, @tag_id]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM books_tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE books_tags SET (book_id, tag_id) = ($1, $2) WHERE id = $3"
    values = [@book_id, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def book()
    return Book.find(@book_id)
  end

  def tag()
    return Tag.find(@tag_id)
  end

end
