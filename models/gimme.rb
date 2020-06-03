require_relative('author')
require_relative('genre')
require_relative('read_status')
require_relative('ownership_status')
require_relative('series')
require_relative('tag')
require_relative('review')
require_relative('book')

class Gimme

  def Gimme.anything()
    all_books = Book.all()
    return all_books.sample()
  end

  def Gimme.buy()
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    books = wishlist.books()
    return books.sample()
  end

  def Gimme.buy_authors()
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    wishlist_author_ids = wishlist.books().map{|book| book.author().id()}.uniq()
    return wishlist_author_ids.map{|author_id| Author.find(author_id)}
  end

  def Gimme.buy_author(author_id)
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    author = Author.find(author_id)
    books = Book.includes(wishlist.books(), author.books())
    return books.sample()
  end

  def Gimme.buy_genres()
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    wishlist_genre_ids = wishlist.books().map{|book| book.genre().id()}.uniq()
    return wishlist_genre_ids.map{|genre_id| Genre.find(genre_id)}
  end

  def Gimme.buy_genre(genre_id)
    genre = Genre.find(genre_id)
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    books = Book.includes(wishlist.books(), genre.books())
    return books.sample()
  end

  def Gimme.buy_tags()
    all_tags = []
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    wishlist_books = wishlist.books()
    for book in wishlist_books
      for tag in book.tags()
        all_tags.push(tag)
      end
    end
    all_tag_ids = all_tags.map{|tag| tag.id()}.uniq()
    return all_tag_ids.map{|tag_id| Tag.find(tag_id)}
  end

  def Gimme.buy_tag(tag_id)
    tag = Tag.find(tag_id)
    wishlist = OwnershipStatus.find_by_name("Wishlist")
    books = Book.includes(wishlist.books(), tag.books())
    return books.sample()
  end

  def Gimme.read()
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    books = Book.includes(bookshelf.books(), not_started.books())
    return books.sample()
  end

  def Gimme.read_author(author_id)
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    author = Author.find(author_id)
    books = Book.includes(all_books, author.books())
    return books.sample()
  end

  def Gimme.read_authors()
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    author_ids = all_books.map{|book| book.author().id()}.uniq()
    return author_ids.map{|author_id| Author.find(author_id)}
  end

  def Gimme.read_genre(genre_id)
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    genre = Genre.find(genre_id)
    books = Book.includes(all_books, genre.books())
    return books.sample()
  end

  def Gimme.read_genres()
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    genre_ids = all_books.map{|book| book.genre().id()}.uniq()
    return genre_ids.map{|genre_id| Genre.find(genre_id)}
  end

  def Gimme.read_format(format_id)
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    format = Format.find(format_id)
    books = Book.includes(all_books, format.books())
    return books.sample()
  end

  def Gimme.read_formats()
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    format_ids = all_books.map{|book| book.format().id()}.uniq()
    return format_ids.map{|format_id| Format.find(format_id)}
  end

  def Gimme.read_tag(tag_id)
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    tag = Tag.find(tag_id)
    books = Book.includes(all_books, tag.books())
    return books.sample()
  end

  def Gimme.read_tags()
    all_tags = []
    bookshelf = OwnershipStatus.find_by_name("Bookshelf")
    not_started = ReadStatus.find_by_name("Not started")
    all_books = Book.includes(bookshelf.books(), not_started.books())
    for book in all_books
      for tag in book.tags()
        all_tags.push(tag)
      end
    end
    all_tag_ids = all_tags.map{|tag| tag.id()}.uniq()
    return all_tag_ids.map{|tag_id| Tag.find(tag_id)}
  end

  def Gimme.recommend()
    books = Book.find_by_rating(4)
    return books.sample()
  end

  def Gimme.recommend_author(author_id)
    author = Author.find(author_id)
    books = Book.includes(Book.find_by_rating(4), author.books())
    return books.sample()
  end

  def Gimme.recommend_authors()
    author_ids = Book.find_by_rating(4).map{|book| book.author().id()}.uniq()
    return author_ids.map{|author_id| Author.find(author_id)}
  end

  def Gimme.recommend_genre(genre_id)
    genre = Genre.find(genre_id)
    books = Book.includes(Book.find_by_rating(4), genre.books())
    return books.sample()
  end

  def Gimme.recommend_genres()
    genre_ids = Book.find_by_rating(4).map{|book| book.genre().id()}.uniq()
    return genre_ids.map{|genre_id| Genre.find(genre_id)}
  end

  def Gimme.recommend_tag(tag_id)
    tag = Tag.find(tag_id)
    books = Book.includes(Book.find_by_rating(4), tag.books())
    return books.sample()
  end

  def Gimme.recommend_tags()
    all_tags = []
    all_books = Book.find_by_rating(4)
    for book in all_books
      for tag in book.tags()
        all_tags.push(tag)
      end
    end
    all_tag_ids = all_tags.map{|tag| tag.id()}.uniq()
    return all_tag_ids.map{|tag_id| Tag.find(tag_id)}
  end

end
