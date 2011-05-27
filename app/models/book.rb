class Book < ActiveRecord::Base
  require 'open-uri'

  #TODO: handle exception for open uri 
  def self.find_google_book(vid)
    uri = "https://www.googleapis.com/books/v1/volumes/" + vid
    google_book = ActiveSupport::JSON.decode(open(uri).read)
    book = Hash.new
    book["google_book_id"] = vid
    book["title"] = google_book["volumeInfo"]["title"]
    book["authors"] = google_book["volumeInfo"]["authors"].join(", ")
    book["description"] = google_book["volumeInfo"]["description"]
    book["thumbnail"] = google_book["volumeInfo"]["imageLinks"]["smallThumbnail"]
    book["pages"] = google_book["volumeInfo"]["pageCount"]
    book["published_date"] = google_book["volumeInfo"]["publishedDate"]
    book
  end

  #TODO: map books
  def self.search_google_books(q)
    if q
      q.gsub! /\s+/, '+'
      uri = "https://www.googleapis.com/books/v1/volumes?q=#{q}" 
      books = ActiveSupport::JSON.decode(open(uri).read)
      books['items']
    end
  end
end
