require_relative('../db/sql_runner')
require_relative('book')

class Format

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Format.delete_all()
    sql = "DELETE FROM formats"
    SqlRunner.run(sql)
  end

  def Format.all()
    sql = "SELECT * FROM formats ORDER BY name"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|genre_info| Format.new(genre_info)}
  end

  def Format.find(id)
    sql = "SELECT * FROM formats WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Format.new(pg_result[0])
  end

  def Format.bookshelf()
    format_ids = Book.bookshelf().map{|book| book.format.id()}.uniq
    formats = format_ids.map{|id| Format.find(id)}
    return formats.sort_by{|format| format.name()}
  end

  def save()
    sql = "INSERT INTO formats (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM formats WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE formats SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def books()
    sql = "SELECT books.* FROM
    formats INNER JOIN books ON formats.id = books.format_id
    WHERE formats.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

end
