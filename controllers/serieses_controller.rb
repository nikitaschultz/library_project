require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/series')
also_reload('../models/*')

get '/serieses' do
  @serieses = Series.all()
  erb(:"serieses/index")
end
