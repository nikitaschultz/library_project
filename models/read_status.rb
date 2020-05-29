require_relative('../db/sql_runner')
require_relative('book')

class ReadStatus

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def ReadStatus.all()
    sql = "SELECT * FROM read_statuses"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|read_status_info| ReadStatus.new(read_status_info)}
  end

  def ReadStatus.find(id)
    sql = "SELECT * FROM read_statuses WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return ReadStatus.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO read_statuses (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM read_statuses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE read_statuses SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def books()
    sql = "SELECT books.* FROM
    read_statuses INNER JOIN books ON books.read_status_id = read_statuses.id
    WHERE read_statuses.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

end
