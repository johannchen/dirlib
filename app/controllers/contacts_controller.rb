class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end
  
  def new
    if params[:profile]
      @contact = Contact.new(:user_id => current_user.id, :email => current_user.email, :name => current_user.name)
    else
      @contact = Contact.new
    end 
  end

  def create
    @contact = Contact.new(params[:contact])

    if @contact.save 
      # create contact under user
      @contact.users << current_user unless params[:profile]
      # TODO: redirect to appropiate url
      redirect_to user_path(current_user), :notice => 'Contact/Profile was created.'
    else
      render :action => "new"
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to user_path(current_user), :notice => 'Contact/Profile was successfully updated.'
    else
      render :action => "edit"
    end
  end

end
