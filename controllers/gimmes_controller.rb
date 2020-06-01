require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/book')
also_reload('../models/*')


get '/gimme' do
  @wishlist = OwnershipStatus.find_by_name("Wishlist")
  @wishlist_author_ids = @wishlist.books().map{|book| book.author.id()}.uniq()
  @wishlist_authors = @wishlist_author_ids.map{|author_id| Author.find(author_id)}
  @wishlist_genre_ids = @wishlist.books().map{|book| book.genre.id()}.uniq()
  @wishlist_genres = @wishlist_genre_ids.map{|genre_id| Genre.find(genre_id)}

  @bookshelf = OwnershipStatus.find_by_name("Bookshelf")
  @not_started = ReadStatus.find_by_name("Not started")
  @bookshelf_not_started_books = Book.includes(@bookshelf.books(), @not_started.books())
  @not_started_author_ids = @bookshelf_not_started_books.map{|book| book.author.id()}.uniq()
  @not_started_authors = @not_started_author_ids.map{|author_id| Author.find(author_id)}
  @not_started_genre_ids = @bookshelf_not_started_books.map{|book| book.genre.id()}.uniq()
  @not_started_genres = @not_started_genre_ids.map{|genre_id| Genre.find(genre_id)}

  @rated_author_ids = Book.find_by_rating(4).map{|book| book.author().id()}.uniq()
  @rated_authors = @rated_author_ids.map{|author_id| Author.find(author_id)}
  @rated_genre_ids = Book.find_by_rating(4).map{|book| book.genre().id()}.uniq()
  @rated_genres = @rated_genre_ids.map{|genre_id| Genre.find(genre_id)}

  erb(:"gimmes/select_view")
end

post '/gimme/anything' do
  @all_books = Book.all()
  sample_book_id = @all_books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/wishlist/author' do
  @author = Author.find(params["author_id"])
  @wishlist = OwnershipStatus.find_by_name("Wishlist")
  @books = Book.includes(@wishlist.books(), @author.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/wishlist/genre' do
  @genre = Genre.find(params["genre_id"])
  @wishlist = OwnershipStatus.find_by_name("Wishlist")
  @books = Book.includes(@wishlist.books(), @genre.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/not_started/author' do
  @author = Author.find(params["author_id"])
  @bookshelf = OwnershipStatus.find_by_name("Bookshelf")
  @not_started = ReadStatus.find_by_name("Not started")
  @bookshelf_not_started_books = Book.includes(@bookshelf.books(), @not_started.books())
  @books = Book.includes(@bookshelf_not_started_books, @author.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/not_started/genre' do
  @genre = Genre.find(params["genre_id"])
  @bookshelf = OwnershipStatus.find_by_name("Bookshelf")
  @not_started = ReadStatus.find_by_name("Not started")
  @bookshelf_not_started_books = Book.includes(@bookshelf.books(), @not_started.books())
  @books = Book.includes(@bookshelf_not_started_books, @genre.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/recommend/author' do
  @author = Author.find(params["author_id"])
  @books = Book.includes(Book.find_by_rating(4), @author.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end

post '/gimme/recommend/genre' do
  @genre = Genre.find(params["genre_id"])
  @books = Book.includes(Book.find_by_rating(4), @genre.books())
  sample_book_id = @books.sample().id()
  redirect("/books/#{sample_book_id}")
end
