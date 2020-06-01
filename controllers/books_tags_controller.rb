require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book_tag')
also_reload('../models/*')

post '/book_tag' do
  book_tag_options = ({"book_id" => params["book_id"], "tag_id" => params["tag_id"]})
  book_tag = BookTag.new(book_tag_options)
  book_tag.save()
  redirect(:"/books/#{book_tag.book().id()}")
end

post '/book_tag/:id/delete' do
  @book_tag = BookTag.find(params["id"])
  book_id = @book_tag.book().id()
  @book_tag.delete()
  redirect(:"/books/#{book_id}")
end

post '/book_tag/delete' do
  redirect(:"/book_tag/#{params["book_tag_id"]}/delete")
end
