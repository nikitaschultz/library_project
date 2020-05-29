require_relative('../db/sql_runner')
require_relative('book')

class Genre

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Genre.all()
    sql = "SELECT * FROM genres"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|genre_info| Genre.new(genre_info)}
  end

  def Genre.find(id)
    sql = "SELECT * FROM genres WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Genre.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO genres (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM genres WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE genres SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def books()
    sql = "SELECT books.* FROM
    genres INNER JOIN books ON genres.id = books.genre_id
    WHERE genres.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

end
