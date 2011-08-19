require 'spec_helper'

describe PostsController do

  def valid_attributes
    {}
  end

  def login
    user = Factory(:user)
    controller.stub!(:current_user).and_return(user)
    return user
  end

  before(:each) do
    @user = login
    @category = Factory(:category)
    @post = Factory(:post)
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      get :index
      assigns(:posts).should eq([@post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      get :show, :id => @post.id.to_s
      assigns(:post).should eq(@post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new
      assigns(:post).should be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post " do
      get :edit, :id => @post.id.to_s
      assigns(:post).should eq(@post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, :post => valid_attributes
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, :post => valid_attributes
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        post :create, :post => valid_attributes
        response.should redirect_to(Post.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, :post => {}
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, :post => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        # Assuming there are no other messages in the database, this
        # specifies that the Message created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @post.id, :post => {'these' => 'params'}
      end

      it "assigns the requested post as @post" do
        put :update, :id => @post.id, :post => valid_attributes
        assigns(:post).should eq(@post)
      end

      it "redirects to the post" do
        put :update, :id => @post.id, :post => valid_attributes
        response.should redirect_to(@post)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, :id => @post.id.to_s, :post => {}
        assigns(:post).should eq(@post)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, :id => @post.id.to_s, :post => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, :id => @post.id.to_s
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, :id => @post.id.to_s
      response.should redirect_to(posts_url)
    end
  end

end
