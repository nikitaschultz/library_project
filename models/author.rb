require_relative('../db/sql_runner')
require_relative('book')

class Author

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def Author.delete_all()
    sql = "DELETE FROM authors"
    SqlRunner.run(sql)
  end

  def Author.all()
    sql = "SELECT * FROM authors ORDER BY first_name" 
    pg_result = SqlRunner.run(sql)
    return pg_result.map{|author_info| Author.new(author_info)}
  end

  def Author.find(id)
    sql = "SELECT * FROM authors WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Author.new(pg_result[0])
  end

  def full_name
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO authors (first_name, last_name) VALUES ($1, $2) RETURNING *"
    values = [@first_name, @last_name]
    pg_result = SqlRunner.run(sql, values)
    @id = pg_result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM authors WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql values)
  end

  def update()
    sql = "UPDATE authors SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def books()
    sql = "SELECT books.* FROM
    authors INNER JOIN books ON authors.id = books.author_id
    WHERE authors.id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map{|book_info| Book.new(book_info)}
  end

end
