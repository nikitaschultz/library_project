require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book')
also_reload('../models/*')

get '/books' do
  @books = Book.all()
end

get '/books/new' do
  @authors = Author.all()
  @genres = Genre.all()
  @read_statuses = ReadStatus.all()
  @ownership_statuses = OwnershipStatus.all()
  @serieses = Series.all()
  erb(:"books/new")
end

get '/books/view' do
  @authors = Author.all()
  @genres = Genre.all()
  @serieses = Series.all()
  @read_statuses = ReadStatus.all()
  @tags = Tag.all()
  @reviews = Review.all()
  erb(:"books/select_view")
end

get '/books/view/:ownership_status_id' do
  @ownership_status = OwnershipStatus.find(params["ownership_status_id"])
  @books = Book.includes(Book.all(), @ownership_status.books())
  @title = @ownership_status.name()
  erb(:"books/index")
end

post '/books/author' do
  redirect("/books/author/#{params["author_id"]}")
end

get '/books/author/:author_id' do
  @author = Author.find(params["author_id"])
  @books = Book.includes(Book.all(), @author.books())
  erb(:"books/by_author")
end

post '/books/genre' do
  redirect("/books/genre/#{params["genre_id"]}")
end

get '/books/genre/:genre_id' do
  @genre = Genre.find(params["genre_id"])
  @books = Book.includes(Book.all(), @genre.books())
  erb(:"books/by_genre")
end

post '/books/series' do
  redirect("/books/series/#{params["series_id"]}")
end

get '/books/series/:series_id' do
  @series = Series.find(params["series_id"])
  @books = Book.includes(Book.all(), @series.books())
  erb(:"books/by_series")
end

post '/books/read_status' do
  redirect("/books/read_status/#{params["read_status_id"]}")
end

get '/books/read_status/:read_status_id' do
  @read_status = ReadStatus.find(params["read_status_id"])
  @books = Book.includes(Book.all(), @read_status.books())
  erb(:"books/by_read_status")
end

get '/books/:id' do
  @book = Book.find(params["id"])
  erb(:"books/show")
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
