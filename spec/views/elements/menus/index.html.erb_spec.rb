require 'rails_helper'

RSpec.describe "menus/index", type: :view do
  before(:each) do
    assign(:menus, [
      Menu.create!(
        :name => "",
        :content => "",
        :parent_id => 1,
        :lft => 2,
        :rgt => 3,
        :depth => 4,
        :children_count => 5
      ),
      Menu.create!(
        :name => "",
        :content => "",
        :parent_id => 1,
        :lft => 2,
        :rgt => 3,
        :depth => 4,
        :children_count => 5
      )
    ])
  end

  it "renders a list of menus" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
