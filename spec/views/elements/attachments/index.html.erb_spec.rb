require 'rails_helper'

RSpec.describe "attachments/index", type: :view do
  before(:each) do
    assign(:attachments, [
      Attachment.create!(
        :name => "Name",
        :file_name => "File Name",
        :file_mime_type => "File Mime Type",
        :file_size => "File Size",
        :creator_id => 1,
        :updater_id => 2
      ),
      Attachment.create!(
        :name => "Name",
        :file_name => "File Name",
        :file_mime_type => "File Mime Type",
        :file_size => "File Size",
        :creator_id => 1,
        :updater_id => 2
      )
    ])
  end

  it "renders a list of attachments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => "File Mime Type".to_s, :count => 2
    assert_select "tr>td", :text => "File Size".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
