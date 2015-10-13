require 'rails_helper'

RSpec.describe "contents/edit", type: :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :name => "MyString",
      :position => 1,
      :creator_id => 1,
      :updater_id => 1
    ))
  end

  it "renders the edit content form" do
    render

    assert_select "form[action=?][method=?]", content_path(@content), "post" do

      assert_select "input#content_name[name=?]", "content[name]"

      assert_select "input#content_position[name=?]", "content[position]"

      assert_select "input#content_creator_id[name=?]", "content[creator_id]"

      assert_select "input#content_updater_id[name=?]", "content[updater_id]"
    end
  end
end
