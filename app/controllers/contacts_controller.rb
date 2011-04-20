class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    params[:contact][:user_id] = params[:user_id] unless params[:user_id].nil?
    @contact = Contact.new(params[:contact])

    if @contact.save
      redirect_to @contact, :notice => 'Profile was created.'
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
      redirect_to @contact, :notice => 'Contact was successfully updated.'
    else
      render :action => "edit"
    end
  end

end
