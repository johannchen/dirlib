require 'spec_helper'

describe "Logins" do
  describe "user logins" do
    it "logins with valid email and password" do
      user = Factory(:user)
      visit log_in_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      current_path.should eq(root_path)
      page.should have_content("Logged in!")
    end

    it "rejects user with invalid email or password" do
      user = Factory(:user)
      visit log_in_path
      fill_in "Email", :with => "nobody@example.com"
      click_button "Log in"
      page.should have_content("Invalid email or password")
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "whatever"
      click_button "Log in"
      page.should have_content("Invalid email or password")
    end
  end
end
