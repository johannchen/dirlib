class Book < ActiveRecord::Base
  require 'open-uri'

  #TODO: handle exception for open uri 
  def google_book_info(vid)
    uri = "https://www.googleapis.com/books/v1/volumes/" + vid
    ActiveSupport::JSON.decode(open(uri).read)
    #self.google_book_id = google_book["id"]
    #self.title = google_book["volumeInfo"]["title"]
    #google_book
  end
end
