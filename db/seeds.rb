require('pry')
require_relative('../models/genre')
require_relative('../models/author')
require_relative('../models/ownership_status')
require_relative('../models/read_status')
require_relative('../models/series')
require_relative('../models/book')
require_relative('../models/review')
require_relative('../models/tag')
require_relative('../models/book_tag')

BookTag.delete_all()
Review.delete_all()
Book.delete_all()
Tag.delete_all()
Genre.delete_all()
Author.delete_all()
Series.delete_all()

####GENRE SEEDS
crime = Genre.new({"name" => "Crime"})
crime.save()
fantasy = Genre.new({"name" => "Fantasy"})
fantasy.save()
scifi = Genre.new({"name" => "Sci-Fi"})
scifi.save()
thriller = Genre.new({"name" => "Thriller"})
thriller.save()
horror = Genre.new({"name" => "Horror"})
horror.save()
youngadult = Genre.new({"name" => "Young Adult"})
youngadult.save()
nonfiction = Genre.new({"name" => "Non-Fiction"})
nonfiction.save()
classic = Genre.new({"name" => "Classic"})
classic.save()
literaryfiction = Genre.new({"name" => "Literary Fiction"})
literaryfiction.save()

####AUTHOR SEEDS
patrickrothfuss = Author.new({"first_name" => "Patrick", "last_name" => "Rothfuss"})
patrickrothfuss.save()
markuszusak = Author.new({"first_name" => "Markus", "last_name" => "Zusak"})
markuszusak.save()
cjtudor = Author.new({"first_name" => "C.J.", "last_name" => "Tudor"})
cjtudor.save()
richarddawkins = Author.new({"first_name" => "Richard", "last_name" => "Dawkins"})
richarddawkins.save()
robertgalbraith = Author.new({"first_name" => "Robert", "last_name" => "Galbraith"})
robertgalbraith.save()
alexnorth = Author.new({"first_name" => "Alex", "last_name" => "North"})
alexnorth.save()
annegriffin = Author.new({"first_name" => "Anne", "last_name" => "Griffin"})
annegriffin.save()
robinhobb = Author.new({"first_name" => "Robin", "last_name" => "Hobb"})
robinhobb.save()
lucyfoley = Author.new({"first_name" => "Lucy", "last_name" => "Foley"})
lucyfoley.save()
jamessacorey = Author.new({"first_name" => "James SA", "last_name" => "Corey"})
jamessacorey.save()

####SERIES SEEDS
series1 = Series.new({"name" => "Kingkiller Chronicles"})
series1.save()
series2 = Series.new({"name" => "Farseer Trilogy"})
series2.save()
series3 = Series.new({"name" => "Cormoran Strike"})
series3.save()

notstarted = ReadStatus.find_by_name("Not started")
finished = ReadStatus.find_by_name("Finished")
inprogress = ReadStatus.find_by_name("In progress")
abandoned = ReadStatus.find_by_name("Abandoned")

bookshelf = OwnershipStatus.find_by_name("Bookshelf")
wishlist = OwnershipStatus.find_by_name("Wishlist")

####BOOK SEEDS
book1 = Book.new({
  "title" => "Assassin's Apprentice",
  "author_id" => robinhobb.id(),
  "genre_id" => fantasy.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id(),
  "series_id" => series2.id(),
  "series_number" => 1
  })
book1.save()
book2 = Book.new({
  "title" => "The Book Thief",
  "author_id" => markuszusak.id(),
  "genre_id" => literaryfiction.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book2.save()
book3 = Book.new({
  "title" => "When All Is Said",
  "author_id" => annegriffin.id(),
  "genre_id" => literaryfiction.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book3.save()
book4 = Book.new({
  "title" => "The Whisper Man",
  "author_id" => alexnorth.id(),
  "genre_id" => thriller.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book4.save()
book5 = Book.new({
  "title" => "The Taking of Annie Thorne",
  "author_id" => cjtudor.id(),
  "genre_id" => horror.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book5.save()
book6 = Book.new({
  "title" => "The Chalk Man",
  "author_id" => cjtudor.id(),
  "genre_id" => horror.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book6.save()
book7 = Book.new({
  "title" => "The Magic of Reality",
  "author_id" => richarddawkins.id(),
  "genre_id" => nonfiction.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id()
  })
book7.save()
book8 = Book.new({
  "title" => "The Cuckoo's Calling",
  "author_id" => robertgalbraith.id(),
  "genre_id" => crime.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id(),
  "series_id" => series3.id(),
  "series_number" => 1
  })
book8.save()
book9 = Book.new({
  "title" => "The Name of the Wind",
  "author_id" => patrickrothfuss.id(),
  "genre_id" => fantasy.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id(),
  "series_id" => series1.id(),
  "series_number" => 1
  })
book9.save()
book10 = Book.new({
  "title" => "The Wise Man's Fear",
  "author_id" => patrickrothfuss.id(),
  "genre_id" => fantasy.id(),
  "read_status_id" => finished.id(),
  "ownership_status_id" => bookshelf.id(),
  "series_id" => series1.id(),
  "series_number" => 2
  })
book10.save()
book11 = Book.new({
  "title" => "The Hunting Party",
  "author_id" => lucyfoley.id(),
  "genre_id" => crime.id(),
  "read_status_id" => notstarted.id(),
  "ownership_status_id" => wishlist.id()
  })
book11.save()
book12 = Book.new({
  "title" => "Levithian Wakes",
  "author_id" => jamessacorey.id(),
  "genre_id" => scifi.id(),
  "read_status_id" => notstarted.id(),
  "ownership_status_id" => wishlist.id()
  })
book12.save()

review1 = Review.new({
  "book_id" => book3.id(),
  "rating" => 5,
  "review" => "Life changing."
  })
review1.save()
review2 = Review.new({
  "book_id" => book4.id(),
  "rating" => 5,
  "review" => "Terrifying and very suspenseful!"
  })
review2.save()
review3 = Review.new({
  "book_id" => book5.id(),
  "rating" => 2,
  "review" => "Very disappointing.  Supernatural element comes from nowhere and is used to explain away the mysterious plot points."
  })
review3.save()
review4 = Review.new({
  "book_id" => book6.id(),
  "rating" => 4,
  "review" => "Very scary and well plotted."
  })
review4.save()

tag1 = Tag.new("name" => "Page-turner")
tag1.save()
tag2 = Tag.new("name" => "Whodunnit")
tag2.save()
tag3 = Tag.new("name" => "Detective Book")
tag3.save()

book_tag1 = BookTag.new({"book_id" => book4.id(), "tag_id" => tag1.id()})
book_tag1.save()
book_tag2 = BookTag.new({"book_id" => book11.id(), "tag_id" => tag2.id()})
book_tag2.save()
book_tag3 = BookTag.new({"book_id" => book8.id(), "tag_id" => tag3.id()})
book_tag3.save()


binding.pry
nil
