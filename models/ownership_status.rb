require_relative('../db/sql_runner')

class OwnershipStatus

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def OwnershipStatus.all()
    sql = "SELECT * FROM ownership_statuses"
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|ownership_status_data| OwnershipStatus.new(ownership_status_data)}
  end

  def OwnershipStatus.find(id)
    sql = "SELECT * FROM ownership_statuses WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return OwnershipStatus.new(pg_result[0])
  end

  def save()
    sql = "INSERT INTO ownership_statuses (name) VALUES ($1) RETURNING *"
    values = [@name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"]
  end

  def delete()
    sql = "DELETE FROM ownership_statuses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE ownership_statuses SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

end
