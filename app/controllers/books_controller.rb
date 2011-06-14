class BooksController < ApplicationController
  load_and_authorize_resource
  after_filter :assign_contact_to_user, :only => [:create, :update]

  def index
    if params[:search]
      @books = Book.search(params[:search]).page(params[:page]).per(5)
    elsif params[:borrow]
      @books = current_user.contact.books.order("title").page(params[:page]).per(5)
    elsif params[:user_id]
      @books = User.find(params[:user_id]).books.order("title").page(params[:page]).per(5)
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
    @book.contact_id = nil if params[:borrower_name_email].blank?
    if @book.update_attributes(params[:book])
      redirect_to @book, :notice => 'Book was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, :notice => 'Book has been successfully deleted.'
  end

private
  def assign_contact_to_user
    # assign contact to current user if borrower is new
    # if the borrower has no relationship, the borrower is a new contact
    if !@book.contact_id.blank? and Relationship.where(:contact_id => @book.contact_id).blank?
      Relationship.create!(:user_id => current_user.id, :contact_id => @book.contact_id)
    end
  end

end
