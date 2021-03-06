require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book')
also_reload('../models/*')

get '/books' do
  @books = Book.all()
  erb(:"books/index")
end

get '/books/new' do
  @authors = Author.all()
  @genres = Genre.all()
  @read_statuses = ReadStatus.all()
  @ownership_statuses = OwnershipStatus.all()
  @serieses = Series.all()
  @formats = Format.all()
  erb(:"books/new")
end

get '/books/view' do
  @authors = Author.bookshelf()
  @genres = Genre.bookshelf()
  @serieses = Series.bookshelf()
  @read_statuses = ReadStatus.all()
  @formats = Format.all()
  @tags = Tag.bookshelf()
  @ratings = [1, 2, 3, 4, 5]
  erb(:"books/select_view")
end

get '/books/view/:ownership_status_id' do
  @ownership_status = OwnershipStatus.find(params["ownership_status_id"])
  @books = Book.includes(Book.all(), @ownership_status.books())
  @title = @ownership_status.name()
  erb(:"books/by_ownership_status")
end

get '/books/author' do
  redirect("/books/author/#{params["author_id"]}")
end

get '/books/author/:author_id' do
  @author = Author.find(params["author_id"])
  @books = Book.includes(Book.bookshelf(), @author.books())
  erb(:"books/by_author")
end

get '/books/genre' do
  redirect("/books/genre/#{params["genre_id"]}")
end

get '/books/genre/:genre_id' do
  @genre = Genre.find(params["genre_id"])
  @books = Book.includes(Book.bookshelf(), @genre.books())
  erb(:"books/by_genre")
end

get '/books/series' do
  redirect("/books/series/#{params["series_id"]}")
end

get '/books/series/:series_id' do
  @series = Series.find(params["series_id"])
  @books = Book.includes(Book.bookshelf(), @series.books())
  erb(:"books/by_series")
end

get '/books/read_status' do
  redirect("/books/read_status/#{params["read_status_id"]}")
end

get '/books/read_status/:read_status_id' do
  @read_status = ReadStatus.find(params["read_status_id"])
  @books = Book.includes(Book.bookshelf(), @read_status.books())
  erb(:"books/by_read_status")
end

get '/books/format' do
  redirect("/books/format/#{params["format_id"]}")
end

get '/books/format/:format_id' do
  @format = Format.find(params["format_id"])
  @books = Book.includes(Book.bookshelf(), @format.books())
  erb(:"books/by_format")
end

get '/books/tag' do
  redirect("/books/tag/#{params["tag_id"]}")
end

get '/books/tag/:tag_id' do
  @tag = Tag.find(params["tag_id"])
  @books = Book.includes(Book.bookshelf(), @tag.books())
  erb(:"books/by_tag")
end

get '/books/rating' do
  redirect("/books/rating/#{params["rating_number"]}")
end

get '/books/rating/:rating_number' do
  @rating = params["rating_number"]
  @books = Book.includes(Book.bookshelf(), Book.find_by_rating(params["rating_number"]))
  erb(:"books/by_rating")
end

get '/books/:id' do
  @tags = Tag.all()
  @book = Book.find(params["id"])
  erb(:"books/show")
end

get '/books/:id/edit' do
  @authors = Author.all()
  @genres = Genre.all()
  @read_statuses = ReadStatus.all()
  @ownership_statuses = OwnershipStatus.all()
  @formats = Format.all()
  @serieses = Series.all()
  @book = Book.find(params["id"])
  erb(:"books/edit")
end

post '/books/:id' do
  if params[:series_id] == "nill"
    params.delete("series_id")
    params.delete("series_number")
  end
  book = Book.new(params)
  book.update()
  redirect("books/#{book.id()}")
end

post '/books/:id/delete' do
  @book = Book.find(params["id"])
  @book.delete()
  redirect('/books/view')
end

post '/books' do
  if params[:series_id] == "nill"
    params.delete("series_id")
    params.delete("series_number")
  end
  @book = Book.new(params)
  @book.save()
  redirect ("/books/#{@book.id()}")
end
