class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @contacts = Contact.search(params[:search])
    else
      @contacts = current_user.contacts 
    end
  end

  def show
  end
  
  def new
    if params[:profile]
      @contact = Contact.new(:user_id => current_user.id, :email => current_user.email, :name => current_user.name)
    end 
  end

  def create
    if @contact.save 
      # create contact under user
      @contact.users << current_user unless params[:profile]
      if @contact.user_id
        redirect_to user_path(current_user), :notice => 'Profile was created.'
      else
        redirect_to @contact, :notice => 'Contact was created.'
      end
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    params[:contact][:group_ids] ||= []

    if @contact.update_attributes(params[:contact])
      if @contact.user_id
        redirect_to user_path(current_user), :notice => 'Profile was successfully updated.'
      else
        redirect_to @contact, :notice => 'Contact was successfully updated.'
      end
    else
      render :action => "edit"
    end
  end

end
