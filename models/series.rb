require_relative('../db/sql_runner')
require_relative('book')

class Series

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Series.delete_all()
    sql = "DELETE FROM serieses"
    SqlRunner.run(sql)
  end

  def Series.all()
    sql = "SELECT * FROM serieses ORDER BY name"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|series_info| Series.new(series_info)}
  end

  def Series.find(id)
    sql = "SELECT * FROM serieses WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Series.new(pg_result[0])
  end

  def Series.bookshelf()
    series_ids = []
    for book in Book.bookshelf()
      if book.series() != nil
        series_ids.push(book.series().id())
      end
    end
    series_ids = series_ids.uniq()
    if series_ids.length > 1
      serieses = series_ids.map{|id| Series.find(id)}
      return serieses.sort_by{|series| series.name()}
    else
      return []
    end
  end

  def save()
    sql = "INSERT INTO serieses (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM serieses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE serieses SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def books()
    sql = "SELECT books.* FROM
    serieses INNER JOIN books ON books.series_id = serieses.id
    WHERE serieses.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

end
