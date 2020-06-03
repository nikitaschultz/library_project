# library_project

Prerequisites:
- gem install sinatra
- gem install sinatra-contrib

Installing:
- Create a database called "library"
- Run the file "library.sql" against your new database
  From the project folder: (psql -d library -f db/library.sql)
- Run the seeds file (if you want)
  - This will add a number of genres, books, reviews and tags
  - Run this first to get a feel for the application and try out the features
  - You can re-run the sql file to clear out the data or delete each item individually within the app
- Run app.rb
- Open http://localhost:4567 in your browser (Chrome tested and suggested)

Testing:
- Specs files in models/specs (test initialize functions)
- If pry gem is installed, can test using the seeds file (uncomment pry('require') and binding.pry)
