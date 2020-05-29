require_relative('../db/sql_runner')

class Genre

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def Genre.all()

  end

  def Genre.find()

  end

  def save()

  end

  def delete()

  end

  def update()

  end

end
