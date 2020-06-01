require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/genre')
also_reload('../models/*')

get '/genres' do
  @genres = Genre.all()
  erb(:"genres/index")
end

get '/genres/new' do
  erb(:"genres/new")
end

post '/genres' do
  genre = Genre.new(params)
  genre.save()
  redirect(:"genres/#{genre.id()}")
end

get '/genres/:id' do
  @genre = Genre.find(params["id"])
  erb(:"genres/show")
end

post '/genres/:id' do
  genre = Genre.new(params)
  genre.update()
  redirect("/genres/#{genre.id()}")
end

get '/genres/:id/edit' do
  @genre = Genre.find(params["id"])
  erb(:"genres/edit")
end

post '/genres/:id/delete' do
  @genre = Genre.find(params["id"])
  @genre.delete()
  redirect('/genres')
end
