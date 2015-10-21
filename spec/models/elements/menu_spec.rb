require 'rails_helper'

module Elements
  RSpec.describe Menu, type: :model do
    it "update the content path based on ancestors and given path" do
      menu_item = FactoryGirl.create(:menu_item).tap do |item|
        item.children << FactoryGirl.create(:menu_item)
        item.save
      end
      item = menu_item.children.first
      expect(item.content.path).to eq("element-content-path") #Factory Content Path
      item.update_path('some-fancy-new-path')
      expect(item.content.path).to eq("/element-content-path/some-fancy-new-path")
      expect(item.content_path).to eq("/element-content-path/some-fancy-new-path")
    end
  end
end
