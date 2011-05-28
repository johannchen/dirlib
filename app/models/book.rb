class Book < ActiveRecord::Base
  require 'open-uri'

  belongs_to :user
  belongs_to :contact

  validates_presence_of :title, :authors

  def self.search(search)
    where(['title like ? or authors like ?', "%#{search}%", "%#{search}%"]).order("title") if search
  end

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
    book["published_year"] = google_book["volumeInfo"]["publishedDate"]
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

  def owner_name 
    #User.find(user_id).name unless user_id.blank?
    user.name if user 
  end

  def borrower_name
    contact.name if contact
  end

end
