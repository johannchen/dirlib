class PostsController < ApplicationController
  load_and_authorize_resource
 
  #TODO: handle archive, report inappropiate 
  def index
    if params[:search]
      @posts = Post.search(params[:search])
    elsif params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.order("created_at desc")
    else
      @posts = Post.order("created_at desc")
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
    end
  end
end
