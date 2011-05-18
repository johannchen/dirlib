class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      @contacts = Contact.search(params[:search]).page(params[:page]).per(5)
    elsif params[:group_id]
      @group = Group.find(params[:group_id])
      @contacts = @group.contacts.active.page(params[:page]).per(5)
    else
      @contacts = current_user.contacts.active.page(params[:page]).per(5)
    end

    @email_alias = @contacts.map(&:email).join(', ')
  end

  def show
  end

  def new
  end

  def create
    if @contact.save 
      if @contact.user_id
        redirect_to user_path(current_user), :notice => 'Profile was created.'
      else
        # create contact under user
        @contact.users << current_user
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
    params[:contact][:status_ids] ||= []

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

  # set contact to inactive rather than delete
  def remove
    @contact = Contact.find(params[:id])
    if @contact.update_attribute :active, false
      redirect_to contacts_url, :notice => "Contact has been successfully removed."
    end
  end

  # list of removed contacts
  def removed
    @contacts = Contact.where(:active => false).order(:name)
  end

  def activate
    @contact = Contact.find(params[:id])
    if @contact.update_attribute :active, true
      redirect_to contacts_url, :notice => "Contact has been successfully activated."
    end
  end
end
