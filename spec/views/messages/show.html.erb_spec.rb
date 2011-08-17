require 'spec_helper'

describe "messages/show.html.erb" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :title => "Title",
      :speaker => "Speaker"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Speaker/)
  end
end
