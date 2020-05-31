require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/author')
also_reload('../models/*')

get '/authors' do
  @authors = Author.all()
end

post '/authors' do
  @author = Author.new(params)
  @author.save()
  redirect request.referer
end

get '/authors/:id' do
  @author = Author.find(params["id"])
  erb(:"authors/show")
end
