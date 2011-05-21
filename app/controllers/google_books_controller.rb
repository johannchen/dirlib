class GoogleBooksController < ApplicationController
  def index
    @books = Book.search_google_books           
  end

  def show
    
  end

end
