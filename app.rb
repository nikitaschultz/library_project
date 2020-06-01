require('sinatra')
require('sinatra/contrib/all')
require_relative('./controllers/books_controller')
require_relative('./controllers/authors_controller')
require_relative('./controllers/serieses_controller')
require_relative('./controllers/genres_controller')
require_relative('./controllers/tags_controller')


get '/' do
  erb(:index)
end

get '/admin' do
  erb(:admin)
end
