require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book')
require_relative('../models/gimme')
also_reload('../models/*')


get '/gimme' do
  @wishlist_authors = Gimme.buy_authors()
  @wishlist_genres = Gimme.buy_genres()
  @wishlist_tags = Gimme.buy_tags()

  @read_authors = Gimme.read_authors()
  @read_genres = Gimme.read_genres()
  @read_tags = Gimme.read_tags()

  @recommend_authors = Gimme.recommend_authors()
  @recommend_genres = Gimme.recommend_genres()
  @recommend_tags = Gimme.recommend_tags()
  erb(:"gimmes/select_view")
end

get '/gimme/anything' do
  book = Gimme.anything()
  redirect("/books/#{book.id()}")
end

get '/gimme/wishlist/author' do
  book = Gimme.buy_author(params["author_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/wishlist/genre' do
  book = Gimme.buy_genre(params["genre_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/wishlist/tag' do
  book = Gimme.buy_genre(params["tag_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/wishlist/anything' do
  book = Gimme.buy()
  redirect("/books/#{book.id()}")
end

get '/gimme/read/author' do
  book = Gimme.read_author(params["author_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/read/genre' do
  book = Gimme.read_genre(params["genre_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/read/tag' do
  book = Gimme.read_tag(params["tag_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/read/anything' do
  book = Gimme.read()
  redirect("/books/#{book.id()}")
end

get '/gimme/recommend/author' do
  book = Gimme.recommend_author(params["author_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/recommend/genre' do
  book = Gimme.recommend_genre(params["genre_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/recommend/tag' do
  book = Gimme.recommend_tag(params["tag_id"])
  redirect("/books/#{book.id()}")
end

get '/gimme/recommend/anything' do
  book = Gimme.recommend()
  redirect("/books/#{book.id()}")
end
