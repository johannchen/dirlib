class GroupsController < ApplicationController
  load_and_authorize_resource

  # GET /groups
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /groups/1
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /groups/new
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    respond_to do |format|
      if @group.save
        format.html { redirect_to(@group, :notice => 'Group was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'Group was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end

  def deactivate
  end

  def activate
  end
end
