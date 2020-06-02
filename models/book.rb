require_relative('../db/sql_runner')
require_relative('author')
require_relative('genre')
require_relative('read_status')
require_relative('ownership_status')
require_relative('series')
require_relative('tag')
require_relative('review')

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

  def Book.includes(array1, array2)
    id_array1 = array1.map{|book| book.id()}
    id_array2 = array2.map{|book| book.id()}
    new_array = id_array1 & id_array2
    return new_array.map{|id| Book.find(id)}
  end

  def Book.find_by_rating(rating)
    sql = "SELECT books.* FROM
    books INNER JOIN reviews ON books.id = reviews.book_id
    WHERE reviews.rating >= $1 ORDER BY books.title"
    values = [rating]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

  def Book.delete_all()
    sql = "DELETE FROM books"
    SqlRunner.run(sql)
  end

  def Book.all()
    sql = "SELECT * FROM books ORDER BY title"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

  def Book.find(id)
    sql = "SELECT * FROM books WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Book.new(pg_result[0])
  end

  def Book.bookshelf()
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    return Book.includes(Book.all(), bookshelf.books())
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
    return Author.find(@author_id)
  end

  def genre()
    return Genre.find(@genre_id)
  end

  def read_status()
    return ReadStatus.find(@read_status_id)
  end

  def ownership_status()
    return OwnershipStatus.find(@ownership_status_id)
  end

  def series()
    return nil if @series_id == nil
    return Series.find(@series_id)
  end

  def review()
    sql = "SELECT reviews.* FROM
    books INNER JOIN reviews ON reviews.book_id = books.id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    begin
      review = Review.find(pg_result[0]["id"])
    rescue
      return nil
    else
      return review
    end
  end

  def books_tags()
    sql = "SELECT books_tags.* FROM
    books INNER JOIN books_tags ON books.id = books_tags.book_id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|tag_info| BookTag.new(tag_info)}
  end

  def tags()
    sql = "SELECT tags.* FROM
    books INNER JOIN books_tags ON books.id = books_tags.book_id
    INNER JOIN tags ON books_tags.tag_id = tags.id
    WHERE books.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|tag_info| Tag.new(tag_info)}
  end

  def tags_not_used()
    all_tags = Tag.all()
    for tag in all_tags
      for used_tag in self.tags()
        if tag.id() == used_tag.id()
          all_tags.delete(tag)
        end
      end
    end
    return all_tags
  end

end
