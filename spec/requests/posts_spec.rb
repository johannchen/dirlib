require 'spec_helper'

describe "Posts" do

  before(:each) do
    user = Factory(:user)
    user_login(user)
  end

  describe "GET /posts" do
    it "displays posts" do
      get posts_path
      response.status.should be(200)
    end
  end

  describe "POST /posts" do
    it "creates post" do
      Factory(:category)
      visit new_post_path
      page.should have_content("Housing")
      fill_in "Title", :with => "house for rent"
      fill_in "Content", :with => "$1500/month 3br"
      select "Housing", :from => "Category"
      click_button "Create Post"
      page.should have_content("Post was successfully created")
    end
  end

  describe "PUT /posts" do
    it "updates post" do
      mypost = Factory(:post)
      assert_equal(mypost.category.name, "Housing", "category should be housing")
      user_login(mypost.user)
      visit edit_post_path(mypost)
      page.should have_content("post content")
      fill_in "Title", :with => "Change Title"
      click_button "Update Post" 
      page.should have_content("Post was successfully updated")
      page.should have_content("Change Title")
      current_path.should eq(post_path(mypost))
    end
  end

end
