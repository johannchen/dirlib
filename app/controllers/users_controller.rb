class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.where(["id != ?", current_user.id]).order("admin DESC, first_name")
  end

  def new
    @contacts = Contact.active_non_user
  end

  def show
    @contact = @user.contact
  end

  def create
    # pre populate name and email from selected contact
    contact = Contact.find(params[:contact][:id])
    @user = User.new(:first_name => contact.first_name, :last_name => contact.last_name, :email => contact.email) 
    # random auto generate password
    @user.new_random_password 
    if @user.save
      # assign contact to user
      contact.update_attribute :user_id, @user.id
      # email confirmation to user
      UserMailer.registration_confirmation(@user).deliver
      redirect_to users_path, :notice => "User was successfully created!"
    else
      render "new" 
    end
  end

  def edit
  end

  def update
    params[:user].delete(:admin) unless current_user.admin
    respond_to do |format|
      if @user.update_attributes(params[:user])
        # email confirmation to user
        UserMailer.registration_confirmation(@user).deliver
        format.html { redirect_to(@user, :notice => 'User was successfully updated.')}
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    if contact = @user.contact
      contact.update_attribute :user_id, nil
    end
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url, :notice => "User has been successfully deleted." }
    end
  end

end
