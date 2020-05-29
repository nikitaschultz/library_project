require('pry')
require_relative('../models/genre')
require_relative('../models/author')
require_relative('../models/ownership_status')

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

####OWNERSHIP STATUS SEEDS
ownershipstatus1 = OwnershipStatus.new({"name" => "Bookshelf"})
ownershipstatus1.save()
ownershipstatus2 = OwnershipStatus.new({"name" => "Wishlist"})
ownershipstatus2.save()
ownershipstatus3 = OwnershipStatus.new({"name" => "Borrowed"})
ownershipstatus3.save()
ownershipstatus4 = OwnershipStatus.new({"name" => "e-Book"})
ownershipstatus4.save()


binding.pry
nil
