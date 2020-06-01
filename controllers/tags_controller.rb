require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get '/tags/new' do
  erb(:"tags/new")
end

post '/tags' do
  tag = Tag.new(params)
  tag.save()
  redirect(:"tags/#{tag.id()}")
end

get '/tags/:id' do
  @tag = Tag.find(params["id"])
  erb(:"tags/show")
end

post '/tags/:id/delete' do
  @tag = Tag.find(params["id"])
  @tag.delete()
  redirect('/tags')
end
