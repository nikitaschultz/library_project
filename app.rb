require('sinatra')
require('sinatra/contrib/all')
require_relative('./controllers/books_controller')

get '/' do
  erb(:index)
end
