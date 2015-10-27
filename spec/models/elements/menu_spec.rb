require 'rails_helper'

module Elements
  RSpec.describe Menu, type: :model do
    it "update the content path based on ancestors and given path" do
      menu_item = FactoryGirl.create(:menu_item).tap do |item|
        item.children << FactoryGirl.create(:menu_item)
        item.save
      end
      item = menu_item.children.first
      item.update_path('some-fancy-new-path')
      expect(item.page.path).to eq("/#{menu_item.page_path}/some-fancy-new-path")
      expect(item.page_path).to eq("/#{menu_item.page_path}/some-fancy-new-path")
    end

    it "translates for fields" do
      menu_item = FactoryGirl.create(:menu_item)
      en_name = menu_item.name
      expect(menu_item.name).to_not be_nil

      I18n.locale = :de

      menu_item.reload.tap do |item|
        expect(menu_item.name).to be_nil
        expect(menu_item.label).to be_nil
        expect(menu_item.title).to be_nil
        expect(menu_item.subtitle).to be_nil
        expect(menu_item.icon_class).to be_nil
        expect(menu_item.custom_attributes).to be_nil
      end

      menu_item.name = "Some German Name"
      menu_item.save
      menu_item.reload

      I18n.locale = :en
      expect(menu_item.name).to eq(en_name)

      I18n.locale = :de
      expect(menu_item.name).to eq("Some German Name")
    end

    it "can't be deleted if page is published" do
      menu_item = FactoryGirl.create(:menu_item)
      menu_item.page.publish!
      expect {
        menu_item.destroy
       }.to raise_error
    end


    it "can't be deleted if is the root of the site" do
      menu_item = FactoryGirl.create( :menu_item, path: '/', name: 'Home')
      expect {
        menu_item.destroy
      }.to raise_error
    end
  end
end
