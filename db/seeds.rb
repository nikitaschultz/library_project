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
OwnershipStatus.delete_all()
ReadStatus.delete_all()
Series.delete_all()

####GENRE SEEDS
genre1 = Genre.new({"name" => "Crime"})
genre1.save()
genre2 = Genre.new({"name" => "Fantasy"})
genre2.save()
genre3 = Genre.new({"name" => "Sci-Fi"})
genre3.save()
genre4 = Genre.new({"name" => "Thriller"})
genre4.save()
genre5 = Genre.new({"name" => "Horror"})
genre5.save()
genre6 = Genre.new({"name" => "Young Adult"})
genre6.save()
genre7 = Genre.new({"name" => "Non-Fiction"})
genre7.save()
genre8 = Genre.new({"name" => "Classic"})
genre8.save()
genre9 = Genre.new({"name" => "Literary Fiction"})
genre9.save()

####AUTHOR SEEDS
author1 = Author.new({"first_name" => "Patrick", "last_name" => "Rothfuss"})
author1.save()
author2 = Author.new({"first_name" => "Markus", "last_name" => "Zusak"})
author2.save()
author3 = Author.new({"first_name" => "C.J.", "last_name" => "Tudor"})
author3.save()
author4 = Author.new({"first_name" => "Richard", "last_name" => "Dawkins"})
author4.save()
author5 = Author.new({"first_name" => "Robert", "last_name" => "Galbraith"})
author5.save()
author6 = Author.new({"first_name" => "Alex", "last_name" => "North"})
author6.save()
author7 = Author.new({"first_name" => "Anne", "last_name" => "Griffin"})
author7.save()
author8 = Author.new({"first_name" => "Robin", "last_name" => "Hobb"})
author8.save()

####OWNERSHIP STATUS SEEDS
ownershipstatus1 = OwnershipStatus.new({"name" => "Bookshelf"})
ownershipstatus1.save()
ownershipstatus2 = OwnershipStatus.new({"name" => "Wishlist"})
ownershipstatus2.save()

####READ STATUS SEEDS
readstatus1 = ReadStatus.new({"name" => "Finished"})
readstatus1.save()
readstatus2 = ReadStatus.new({"name" => "In progress"})
readstatus2.save()
readstatus3 = ReadStatus.new({"name" => "Abandoned"})
readstatus3.save()
readstatus4 = ReadStatus.new({"name" => "Not started"})
readstatus4.save()

####SERIES SEEDS
series1 = Series.new({"name" => "Kingkiller Chronicles"})
series1.save()
series2 = Series.new({"name" => "Farseer Trilogy"})
series2.save()

####BOOK SEEDS
book1 = Book.new({
  "title" => "Assassin's Apprentice",
  "author_id" => author8.id(),
  "genre_id" => genre2.id(),
  "read_status_id" => readstatus4.id(),
  "ownership_status_id" => ownershipstatus1.id(),
  "series_id" => series2.id(),
  "series_number" => 1
  })
book1.save()
book2 = Book.new({
  "title" => "The Book Thief",
  "author_id" => author2.id(),
  "genre_id" => genre9.id(),
  "read_status_id" => readstatus4.id(),
  "ownership_status_id" => ownershipstatus1.id()
  })
book2.save()
book3 = Book.new({
  "title" => "When All Is Said",
  "author_id" => author7.id(),
  "genre_id" => genre9.id(),
  "read_status_id" => readstatus4.id(),
  "ownership_status_id" => ownershipstatus1.id()
  })
book3.save()
book4 = Book.new({
  "title" => "The Whisper Man",
  "author_id" => author6.id(),
  "genre_id" => genre4.id(),
  "read_status_id" => readstatus4.id(),
  "ownership_status_id" => ownershipstatus1.id()
  })
book4.save()
book5 = Book.new({
  "title" => "The Taking of Annie Thorne",
  "author_id" => author3.id(),
  "genre_id" => genre5.id(),
  "read_status_id" => readstatus1.id(),
  "ownership_status_id" => ownershipstatus2.id()
  })
book5.save()
book6 = Book.new({
  "title" => "The Chalk Man",
  "author_id" => author3.id(),
  "genre_id" => genre5.id(),
  "read_status_id" => readstatus1.id(),
  "ownership_status_id" => ownershipstatus2.id()
  })
book6.save()


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
tag2 = Tag.new("name" => "Twisty")
tag2.save()

book_tag1 = BookTag.new({"book_id" => book4.id(), "tag_id" => tag1.id()})
book_tag1.save()
book_tag2 = BookTag.new({"book_id" => book3.id(), "tag_id" => tag2.id()})
book_tag2.save()

tag2_id_array = tag2.books().map{|book| book.id()}
genre9_id_array = genre9.books().map{|book| book.id()}

test = tag2_id_array & genre9_id_array
book_test = test.map{|id| Book.find(id)}

binding.pry
nil
