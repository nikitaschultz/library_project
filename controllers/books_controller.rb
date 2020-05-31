require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book')
also_reload('../models/*')

get '/books' do
  @books = Book.all()
end

get '/books/:id' do
  @book = Book.find(params["id"])
  erb(:"books/show")
end

get '/books/new' do
  erb(:"books/new")
end

post '/books' do
  @book = Book.new(params)
  @book.save()
  redirect to ("/books/show")
end
