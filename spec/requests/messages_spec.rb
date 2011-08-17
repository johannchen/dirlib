require 'spec_helper'

describe "Messages" do
  describe "GET /messages" do
    it "displays messages" do
      get messages_path
      response.status.should be(200)
    end
  end
end
