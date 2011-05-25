class BooksController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @google_books = Book.search_google_books(params[:q]) 
  end

  def show
  end

  def create

  end
end
