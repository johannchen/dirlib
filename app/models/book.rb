class Book < ActiveRecord::Base
  require 'open-uri'

  belongs_to :user
  belongs_to :contact

  validates_presence_of :title, :authors
  validates_format_of :borrower_name_email, :with => /^\D+\s\D+\s<([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})>/i, :allow_blank => true, :on => :update

  def self.search(search)
    where(['title like ? or authors like ?', "%#{search}%", "%#{search}%"]).order("title") if search
  end

  def self.find_google_book(vid)
    uri = "https://www.googleapis.com/books/v1/volumes/" + vid
    google_book = ActiveSupport::JSON.decode(open(uri).read)
    book = Hash.new
    book["google_book_id"] = vid
    book["title"] = google_book["volumeInfo"]["title"] unless google_book["volumeInfo"]["title"].blank?
    book["authors"] = google_book["volumeInfo"]["authors"].join(", ") unless google_book["volumeInfo"]["authors"].blank?
    book["description"] = google_book["volumeInfo"]["description"] unless google_book["volumeInfo"]["description"].blank?
    book["thumbnail"] = google_book["volumeInfo"]["imageLinks"]["smallThumbnail"] unless google_book["volumeInfo"]["imageLinks"]["smallThumbnail"].blank?
    book["pages"] = google_book["volumeInfo"]["pageCount"] unless google_book["volumeInfo"]["pageCount"].blank?
    book["published_year"] = google_book["volumeInfo"]["publishedDate"] unless google_book["volumeInfo"]["publishedDate"].blank?
    book

    rescue
      book = ""
  end

  def self.search_google_books(q)
    if q
      q.gsub! /\s+/, '+'
      uri = "https://www.googleapis.com/books/v1/volumes?q=#{q}" 
      books = ActiveSupport::JSON.decode(open(uri).read)
      books['items']
    end
  end

  def owner_name 
    user.name if user 
  end

  def borrower_name
    contact.name if contact
  end

  def borrower_name_email
    contact.name_email if contact
  end

  def borrower_name_email=(name_email)
    unless name_email.blank?  
      # name_email format e.g. John Wu <johnwu@mail.com>
      # parse name_email
      s = name_email.split
      first_name = s.first
      last_name = s[1]
      email = s.last.gsub(/<|>/, '')
      self.contact = Contact.find_or_create_by_first_name_and_last_name_and_email(first_name, last_name, email)
    end
  end
end
