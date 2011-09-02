require 'spec_helper'

describe "messages/index.html.erb" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :title => "Title",
        :speaker => "Speaker"
      ),
      stub_model(Message,
        :title => "Title",
        :speaker => "Speaker"
      )
    ])
  end

  it "renders a list of messages" do
  end
end
