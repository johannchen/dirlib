class Book < ActiveRecord::Base
  require 'open-uri'

  #TODO: handle exception for open uri 
  def find_google_book(vid)
    uri = "https://www.googleapis.com/books/v1/volumes/" + vid
    ActiveSupport::JSON.decode(open(uri).read)
    #self.google_book_id = google_book["id"]
    #self.title = google_book["volumeInfo"]["title"]
    #google_book
  end

  #TODO: map books
  def self.search_google_books
    uri = "https://www.googleapis.com/books/v1/volumes?q=mere+christianity" 
    books = ActiveSupport::JSON.decode(open(uri).read)
    books['items']
  end
end
