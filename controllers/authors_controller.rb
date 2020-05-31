require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/author')
also_reload('../models/*')

get '/authors' do
  @authors = Author.all()
  erb(:"authors/index")
end

post '/authors' do
  @author = Author.new(params)
  @author.save()
  redirect("/authors/#{@author.id()}")
end

get '/authors/new' do
  erb(:"authors/new")
end

get '/authors/:id' do
  @author = Author.find(params["id"])
  erb(:"authors/show")
end

post '/authors/:id/delete' do
  @author = Author.find(params["id"])
  @author.delete()
  redirect('/authors')
end
