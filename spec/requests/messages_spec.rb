require 'spec_helper'

describe "Messages" do
  describe "GET /messages" do
    it "displays messages" do
      3.times do 
        Factory(:message)
      end
      visit messages_path
      assert_equal(Message.all.count, 3, "should see all messages")
    end
  end
end
