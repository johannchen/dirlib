require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = Factory(:user)
    visit log_in_path
    click_link "password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    current_path.should eq(root_path)
  end
end
