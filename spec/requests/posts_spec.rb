require 'spec_helper'

describe "Posts" do

  #def login_as(user_type)
  #  user = Factory.build(user_type)
  #  controller.stub!(:current_user).and_return(user)
  #  return user
  #end
  #before(:each) do
  #  @user = login_as(:user)
  #end

  describe "GET /posts" do
    it "displays posts" do
      get posts_path
      response.status.should be(200)
    end
  end

  describe "POST /posts" do
    it "creates post" do
      user = Factory(:user)
      ApplicationController.stub!(:current_user).and_return(user)
      visit new_post_path
      fill_in "Title", :with => "house for rent"
      fill_in "Content", :with => "$1500/month 3br"
      # select "Housing", :from => "category_id"
      # click_button "Create Post"
      #page.should have_content("Post was created successfully.")
    end 
  end
end
