DROP TABLE IF EXISTS books_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS formats;
DROP TABLE IF EXISTS read_statuses;
DROP TABLE IF EXISTS ownership_statuses;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS serieses;

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE formats (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE read_statuses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE ownership_statuses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) not null,
  last_name VARCHAR(255) not null
);

CREATE TABLE serieses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) not null,
  author_id INT REFERENCES authors(id) ON DELETE CASCADE,
  genre_id INT REFERENCES genres(id) ON DELETE CASCADE,
  format_id INT REFERENCES formats(id) ON DELETE CASCADE,
  read_status_id INT REFERENCES read_statuses(id) ON DELETE CASCADE,
  ownership_status_id INT REFERENCES ownership_statuses(id) ON DELETE CASCADE,
  series_id INT REFERENCES serieses(id) ON DELETE CASCADE,
  series_number INT
);

CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  book_id INT REFERENCES books(id) ON DELETE CASCADE,
  review TEXT,
  rating INT
);

CREATE TABLE tags(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE books_tags(
  id SERIAL PRIMARY KEY,
  book_id INT REFERENCES books(id) ON DELETE CASCADE,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE
);

INSERT INTO ownership_statuses (name) VALUES ('Bookshelf');
INSERT INTO ownership_statuses (name) VALUES ('Wishlist');
INSERT INTO read_statuses (name) VALUES ('Finished');
INSERT INTO read_statuses (name) VALUES ('In progress');
INSERT INTO read_statuses (name) VALUES ('Abandoned');
INSERT INTO read_statuses (name) VALUES ('Not started');
