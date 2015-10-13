require 'rails_helper'

RSpec.describe "contents/index", type: :view do
  before(:each) do
    assign(:contents, [
      Content.create!(
        :name => "Name",
        :position => 1,
        :creator_id => 2,
        :updater_id => 3
      ),
      Content.create!(
        :name => "Name",
        :position => 1,
        :creator_id => 2,
        :updater_id => 3
      )
    ])
  end

  it "renders a list of contents" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
