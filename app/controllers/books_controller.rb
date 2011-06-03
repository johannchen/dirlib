class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @books = Book.search(params[:search]).page(params[:page]).per(5)
    elsif params[:borrow]
      @books = current_user.contact.books.order("title").page(params[:page]).per(5)
    else 
      @books = current_user.books.order("title").page(params[:page]).per(5)
    end
  end

  def new
    @google_books = Book.search_google_books(params[:q]) 
  end

  def show
  end

  def edit
  end

  def create
    # create book from google api
    unless params[:google_book_id].nil?
      google_book = Book.find_google_book(params[:google_book_id])
      @book = Book.new(google_book)
    end 

    #create book from regular form
    @book.user_id = current_user.id
    
    if @book.save
      redirect_to books_path, :notice => "Book was successfully added!"
    else 
      render "new", :notice => "Sorry, somehow it fails to add the book."
    end 
  end

  def update
    if @book.update_attributes(params[:book])
      redirect_to @book, :notice => 'Book was successfully updated.'
    else
      render :action => "edit"
    end
  end
end
