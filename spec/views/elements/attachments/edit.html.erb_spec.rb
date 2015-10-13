require 'rails_helper'

RSpec.describe "attachments/edit", type: :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :name => "MyString",
      :file_name => "MyString",
      :file_mime_type => "MyString",
      :file_size => "MyString",
      :creator_id => 1,
      :updater_id => 1
    ))
  end

  it "renders the edit attachment form" do
    render

    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do

      assert_select "input#attachment_name[name=?]", "attachment[name]"

      assert_select "input#attachment_file_name[name=?]", "attachment[file_name]"

      assert_select "input#attachment_file_mime_type[name=?]", "attachment[file_mime_type]"

      assert_select "input#attachment_file_size[name=?]", "attachment[file_size]"

      assert_select "input#attachment_creator_id[name=?]", "attachment[creator_id]"

      assert_select "input#attachment_updater_id[name=?]", "attachment[updater_id]"
    end
  end
end
