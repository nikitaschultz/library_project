require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/format')
also_reload('../models/*')

get '/formats' do
  @formats = Format.all()
  erb(:"formats/index")
end

get '/formats/new' do
  erb(:"formats/new")
end

post '/formats' do
  format = Format.new(params)
  format.save()
  redirect(:"formats/#{format.id()}")
end

get '/formats/:id' do
  @format = Format.find(params["id"])
  erb(:"formats/show")
end

post '/formats/:id' do
  format = Format.new(params)
  format.update()
  redirect("/formats/#{format.id()}")
end

get '/formats/:id/edit' do
  @format = Format.find(params["id"])
  erb(:"formats/edit")
end

post '/formats/:id/delete' do
  @format = Format.find(params["id"])
  @format.delete()
  redirect('/formats')
end
