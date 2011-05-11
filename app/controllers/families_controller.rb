class FamiliesController < ApplicationController
  load_and_authorize_resource

  def index
    # @families = Family.where(['name like ?', "%#{params[:search]}%"])
    respond_to do |format|
      format.html
      format.json { render :json => @families.order(:name).map(&:name) } 
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @family.save
        format.html { redirect_to(@family, :notice => 'Family was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @family.update_attributes(params[:family])
        format.html { redirect_to(@family, :notice => 'Family was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @family.destroy

    respond_to do |format|
      format.html { redirect_to(families_url) }
    end
  end
end
