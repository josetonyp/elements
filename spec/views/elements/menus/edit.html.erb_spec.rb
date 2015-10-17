require 'rails_helper'

RSpec.describe "menus/edit", type: :view do
  before(:each) do
    @menu = assign(:menu, Menu.create!(
      :name => "",
      :content => "",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1,
      :depth => 1,
      :children_count => 1
    ))
  end

  it "renders the edit menu form" do
    render

    assert_select "form[action=?][method=?]", menu_path(@menu), "post" do

      assert_select "input#menu_name[name=?]", "menu[name]"

      assert_select "input#menu_content[name=?]", "menu[content]"

      assert_select "input#menu_parent_id[name=?]", "menu[parent_id]"

      assert_select "input#menu_lft[name=?]", "menu[lft]"

      assert_select "input#menu_rgt[name=?]", "menu[rgt]"

      assert_select "input#menu_depth[name=?]", "menu[depth]"

      assert_select "input#menu_children_count[name=?]", "menu[children_count]"
    end
  end
end
