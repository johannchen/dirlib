class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.where(["id != ?", current_user.id]).active
  end

  def new
    @contacts = Contact.active_non_user
  end

  def show
    @contact = current_user.contact
  end

  def create
    # pre populate name and email from selected contact
    contact = Contact.find(params[:contact][:id])
    @user = User.new(:first_name => contact.first_name, :last_name => contact.last_name, :email => contact.email, :admin => params[:user][:admin]) 
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
    params[:user].delete(:password) if params[:user][:password].blank?
    respond_to do |format|
      if @user.update_attributes(params[:user])
        if params[:user][:password]
          # email confirmation to user
          UserMailer.registration_confirmation(@user).deliver 
          if current_user.admin
            format.html { redirect_to(users_path, :notice => 'User was successfully updated.')}
          else
            format.html { redirect_to(@user, :notice => 'Password was successfully updated.')}
          end
        else 
          format.html { redirect_to(users_path, :notice => 'Contact assignments were successfully updated.')}
        end
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

  # assign contacts
  def assign 
    @user = User.find(params[:id])
  end

  # set user to inactive rather than delete
  def disable
    @user = User.find(params[:id])
    if @user.update_attribute :active, false
      redirect_to users_url, :notice => "User has been successfully disabled."
    end 
  end

  def activate
    @user = User.find(params[:id])
    if @user.update_attribute :active, true
      redirect_to users_url, :notice => "User has been successfully activated."
    end
  end

  def disabled 
    @users = User.where(:active => false).order(:first_name)
  end
end
