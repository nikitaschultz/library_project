require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/series')
also_reload('../models/*')

get '/serieses' do
  @serieses = Series.all()
  erb(:"serieses/index")
end

post '/serieses' do
  @series = Series.new(params)
  @series.save()
  redirect("/serieses/#{@series.id()}")
end

get '/serieses/new' do
  erb(:"serieses/new")
end

get '/serieses/:id' do
  @series = Series.find(params["id"])
  erb(:"serieses/show")
end

post '/serieses/:id/delete' do
  @series = Series.find(params["id"])
  @series.delete()
  redirect('/serieses')
end
