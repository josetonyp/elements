require 'rails_helper'

RSpec.describe "chips/index", type: :view do
  before(:each) do
    assign(:chips, [
      Chip.create!(
        :value => "MyText",
        :key => "Key",
        :path => "MyText",
        :parent_id => 1
      ),
      Chip.create!(
        :value => "MyText",
        :key => "Key",
        :path => "MyText",
        :parent_id => 1
      )
    ])
  end

  it "renders a list of chips" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
