require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book_tag')
also_reload('../models/*')

post '/book_tag' do
  book_tag = BookTag.new(params)
  book_tag.save()
end

post '/genres/:id/delete' do
  @book_tag = BookTag.find(params["id"])
  @book_tag.delete()
end
