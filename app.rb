require('sinatra')
require('sinatra/contrib/all')
require_relative('./controllers/books_controller')
require_relative('./controllers/authors_controller')

get '/' do
  erb(:index)
end
