require_relative('../db/sql_runner')
require_relative('author')
require_relative('genre')
require_relative('read_status')
require_relative('ownership_status')
require_relative('series')

class Book

  attr_reader :id, :author_id, :genre_id, :read_status_id, :series_id, :ownership_status_id
  attr_accessor :title, :series_number

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @author_id = options["author_id"]
    @genre_id = options["genre_id"]
    @read_status_id = options["read_status_id"]
    @ownership_status_id = options["ownership_status_id"]
    @series_id = options["series_id"]
    @series_number = options["series_number"]
  end

  def Book.delete_all()
    sql = "DELETE FROM books"
    SqlRunner.run(sql)
  end

  def Book.all()
    sql = "SELECT * FROM books"
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

  def Book.find(id)
    sql = "SELECT * FROM books WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Book.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO books (title, author_id, genre_id, read_status_id, ownership_status_id, series_id, series_number) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *"
    values = [@title, @author_id, @genre_id, @read_status_id, @ownership_status_id, @series_id, @series_number]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM books WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE books SET (title, author_id, genre_id, read_status_id, ownership_status_id, series_id, series_number) = ($1, $2, $3, $4, $5, $6, $7) WHERE id = $8"
    values = [@title, @author_id, @genre_id, @read_status_id, @ownership_status_id, @series_id, @series_number, @id]
    SqlRunner.run(sql, values)
  end

  def author()
    sql = "SELECT authors.* FROM
          books INNER JOIN authors ON authors.id = books.author_id
          WHERE books.author_id = $1"
    values = [@author_id]
    pg_result = SqlRunner.run(sql, values)
    return Author.new(pg_result[0])
  end

  def genre()
    sql = "SELECT genres.* FROM
    books INNER JOIN genres ON genres.id = books.genre_id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return Genre.new(pg_result[0])
  end

  def read_status()
    sql = "SELECT read_statuses.* FROM
    books INNER JOIN read_statuses ON read_statuses.id = books.read_status_id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return ReadStatus.new(pg_result[0])
  end

  def ownership_status()
    sql = "SELECT ownership_statuses.* FROM
    books INNER JOIN ownership_statuses ON ownership_statuses.id = books.ownership_status_id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return OwnershipStatus.new(pg_result[0])
  end

  def series()
    return nil if @series_id == nil
    sql = "SELECT serieses.* FROM
    books INNER JOIN serieses ON books.series_id = serieses.id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return Series.new(pg_result[0])
  end

  def review()
    sql = "SELECT reviews.* FROM
    books INNER JOIN reviews ON reviews.book_id = books.id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    begin
      review = Review.new(pg_result[0])
    rescue
      return nil
    else
      return review
    end
  end

end
