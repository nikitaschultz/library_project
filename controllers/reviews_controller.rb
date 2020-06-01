require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/review')
also_reload('../models/*')

get '/reviews' do
  @reviews = Review.all()
  erb(:"reviews/index")
end

post '/reviews' do
  review = Review.new(params)
  review.save()
  redirect("/books/#{review.book().id()}")
end

get '/reviews/:book_id/new' do
  @book = Book.find(params["book_id"])
  erb(:"reviews/new")
end

get '/reviews/:id/edit' do
  @review = Review.find(params["id"])
  erb(:"reviews/edit")
end

post '/reviews/:id' do
  review = Review.new(params)
  review.update
  redirect("/books/#{review.book().id()}")
end

post '/reviews/:id/delete' do
  review = Review.find(params["id"])
  book_id = review.book().id()
  review.delete()
  redirect("/books/#{book_id}")
end
