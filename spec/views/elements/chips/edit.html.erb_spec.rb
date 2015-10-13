require 'rails_helper'

RSpec.describe "chips/edit", type: :view do
  before(:each) do
    @chip = assign(:chip, Chip.create!(
      :value => "MyText",
      :key => "MyString",
      :path => "MyText",
      :parent_id => 1
    ))
  end

  it "renders the edit chip form" do
    render

    assert_select "form[action=?][method=?]", chip_path(@chip), "post" do

      assert_select "textarea#chip_value[name=?]", "chip[value]"

      assert_select "input#chip_key[name=?]", "chip[key]"

      assert_select "textarea#chip_path[name=?]", "chip[path]"

      assert_select "input#chip_parent_id[name=?]", "chip[parent_id]"
    end
  end
end
