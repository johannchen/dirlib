class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:search]
      contact_alias = Contact.search(params[:search])
      @contacts = contact_alias.page(params[:page]).per(5)
    elsif params[:group_id]
      @group = Group.find(params[:group_id])
      contact_alias = @group.contacts.active
      @contacts = contact_alias.page(params[:page]).per(5)
    elsif params[:term]
      # jquery auto complete
      @contacts = Contact.auto_complete(params[:term])
    elsif params[:q]
      # token input auto complete
      @contacts = Contact.search(params[:q])
    else
      contact_alias = current_user.contacts.active
      @contacts = contact_alias.page(params[:page]).per(5)
    end

    unless params[:term] or params[:q]
      @contacts_count = contact_alias.size 
      @email_alias = contact_alias.with_email.map(&:name_email).join(', ') 
    end

    respond_to do |format|
      format.html
      format.json { render :json => @contacts.order(:first_name).map{|c| {"id" => c.id, "name" => c.name + " - " + c.email}} } if params[:q]
      format.json { render :json => @contacts.order(:first_name).map(&:name_email) } if params[:term]
    end
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
  
    @contact.family_id = nil if params[:family_name].blank?
    if @contact.update_attributes(params[:contact])
      if @contact.user_id == current_user.id
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
    @contacts = Contact.where(:active => false).order(:first_name)
  end

  def activate
    @contact = Contact.find(params[:id])
    if @contact.update_attribute :active, true
      redirect_to contacts_url, :notice => "Contact has been successfully activated."
    end
  end

  def print
    @contacts = Contact.printed_members
  end
end
