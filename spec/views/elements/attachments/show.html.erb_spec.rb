require 'rails_helper'

RSpec.describe "attachments/show", type: :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :name => "Name",
      :file_name => "File Name",
      :file_mime_type => "File Mime Type",
      :file_size => "File Size",
      :creator_id => 1,
      :updater_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(/File Mime Type/)
    expect(rendered).to match(/File Size/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
