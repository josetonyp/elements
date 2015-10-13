require 'rails_helper'

RSpec.describe "chips/show", type: :view do
  before(:each) do
    @chip = assign(:chip, Chip.create!(
      :value => "MyText",
      :key => "Key",
      :path => "MyText",
      :parent_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
