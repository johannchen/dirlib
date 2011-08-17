require 'spec_helper'

describe "messages/new.html.erb" do
  before(:each) do
    assign(:message, stub_model(Message,
      :title => "MyString",
      :speaker => "MyString"
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "input#message_title", :name => "message[title]"
      assert_select "input#message_speaker", :name => "message[speaker]"
    end
  end
end
