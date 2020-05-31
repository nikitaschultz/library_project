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

get '/books/:id' do
  @book = Book.find(params["id"])
  erb(:"books/show")
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
