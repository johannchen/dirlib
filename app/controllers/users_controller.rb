class UsersController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def show
    @contact = @user.contact
  end

  def create
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new" 
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.')}
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
