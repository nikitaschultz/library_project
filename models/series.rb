require_relative('../db/sql_runner')

class Series

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Series.all()
    sql = "SELECT * FROM serieses"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|series_info| Series.new(series_info)}
  end

  def Series.find(id)
    sql = "SELECT * FROM serieses WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Series.new(pg_result[0])
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

end
