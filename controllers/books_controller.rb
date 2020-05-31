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

get '/books/view/:ownership_status_id' do
  @ownership_status = OwnershipStatus.find(params["ownership_status_id"])
  @books = Book.includes(Book.all(), @ownership_status.books())
  erb(:"books/index")
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
