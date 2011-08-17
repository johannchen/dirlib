require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "displays posts" do
      user = Factory(:user, :id => 1)
      contact = Factory(:contact)
      get posts_path
      response.status.should be(200)
    end
  end

  describe "POST /posts" do
    it "creates post" do
      visit new_post_path
      fill_in "Title", :with => "house for rent"
      fill_in "Description", :with => "$1500/month 3br"
      select "Housing", :from => "category"
      click_button "Create Post"
      page.should have_content("Post was created successfully.")
      
    end 
  end
end
