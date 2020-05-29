require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Tag.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def Tag.all()
    sql = "SELECT * FROM tags"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|tag_info| Tag.new(tag_info)}
  end

  def Tag.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Tag.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tags SET name = $1"
    values = [@name]
    SqlRunner.run(sql, values)
  end

end
