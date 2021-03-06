require 'spec_helper'

describe "Messages" do
  describe "display a list of all messages" do
    before :each do
      10.times do 
        Factory(:message)
      end
      @m1 = Factory(:message, :title => "my message", :speaker => "Jonathan", :mdate => "2011-08-01")
      @m2 = Factory(:message, :title => "your message", :speaker => "my Eric", :mdate => "2011-08-02")
      visit messages_path
    end

    it "displays messages with the latest on top" do
      page.first("#messages li").should have_content(@m2.mdate)
    end
    it "paginates with every 10 messages" do
      display_all_messages_with_pagination
    end
   
    describe "search messages" do
      it "displays all messages with empty search" do 
        fill_in "Search", :with => ""
        click_button "Search"
        display_all_messages_with_pagination
      end
      it "displays all matched messages with title or speaker search" do
        fill_in "Search", :with => "my"
        click_button "Search"
        page.all("#messages li").count.should eq(2)
        page.should have_content("my message")
        page.should have_content("my Eric")
        page.should have_no_link("Next")
      end
      it "displays no messages found when no record returns" do
        fill_in "Search", :with => "whatever"
        click_button "Search"
        page.all("#messages li").count.should eq(0)
        page.should have_content("no messages found") 
        page.should have_no_link("Next")
      end
    end 
  end

  describe "show a specific message" do
    it "shows a message" do
      message = Factory(:message)
      visit message_path(message)
      page.should have_content("what a message!")
      page.should have_content("John 3:16")
      page.should have_content("God so loved the world")
    end 
  end 
 
  describe "create a new message" do
    it "creates message" do
      visit new_message_path
      click_button "Create"
      page.should have_content("Title can't be blank")
      page.should have_content("Speaker can't be blank")
      page.should have_content("Mdate can't be blank")
      fill_in "Title", :with => "sunday message"
      fill_in "Speaker", :with => "bob"
      fill_in "Mdate", :with => "2011-09-01"
      click_button "Create"
      page.should have_content("Message was successfully created")
      current_path.should eq(message_path(Message.last))
    end
  end
  
  describe "update a specific message" do
    it "updates message" do
      message = Factory(:message)
      visit edit_message_path(message)
      page.should have_field("Speaker", :with => "foo lee")
      fill_in "Speaker", :with => ""
      click_button "Update"
      page.should have_content("Speaker can't be blank")
      fill_in "Speaker", :with => "bob"
      click_button "Update"
      page.should have_content("Message was successfully updated")
      page.should have_content("bob")
      current_path.should eq(message_path(message))
    end
  end

#  describe "DELETE /messages" do 
#    it "destroys message", :js => true do
#      message = Factory(:message)
#      visit messages_path
#      page.should have_content("foo lee")
#      page.should have_link("Delete")
#      click_link "Delete"
#      page.should have_content("Are you sure?")
#      click_button "Ok"
#      page.should have_no_content("foo lee")
#    end
#  end

  private
  def display_all_messages_with_pagination
    page.all("#messages li").count.should eq(10)
    page.should have_link("Next")
    click_link "Next"
    page.all("#messages li").count.should eq(2)
    page.should have_link("Prev")
    click_link "Prev"
    page.all("#messages li").count.should eq(10)
  end 
end
