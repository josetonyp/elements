require 'rails_helper'
module Elements
  RSpec.describe MenusController, type: :controller do
    routes { Elements::Engine.routes }

    before(:each) do
      Menu.destroy_all
    end

    let(:menu_item) do
      FactoryGirl.create(:menu_item).tap do |item|
        item.children << FactoryGirl.create(:menu_item)
        item.save
      end
    end

    describe "GET #index" do
      it "assigns all menus as @menus" do
        menu_item
        get :index, { format: :json }
        JSON.parse(response.body).tap do |menus|
          expect(menus.count).to eq(2)
          expect(menus.last['parent_id']).to eq( menus.first['id'] )
        end
      end
    end

    describe "GET #show" do
      it "assigns the requested menu as @menu" do
        menu_item
        get :show, { format: :json, :id => menu_item.to_param }
        JSON.parse(response.body).tap do |menu|
          expect(menu['id']).to eq(menu_item.id)
        end
      end
    end


    describe "POST #create" do
      context "with valid params" do
        it "creates a new Menu" do
          expect {
            post :create, { format: :json, :menu => FactoryGirl.attributes_for(:menu_item)}
          }.to change(Menu, :count).by(1)
          expect(Menu.last.page).to be_present
        end

        it "creates a menu item under other item" do
          menu_item
          new_menu = FactoryGirl.attributes_for(:menu_item)
          new_menu[:parent_id] = menu_item.children.first.id
          expect {
            post :create, { format: :json, :menu => new_menu }
          }.to change(Menu, :count).by(1)
          JSON.parse(response.body).tap do |menu|
            expect(menu["parent_id"]).to eq(menu_item.children.first.id)
            expect(menu["depth"]).to eq(2)
          end
        end


        it "creates a menu specifying its path to the content" do
          root_item = FactoryGirl.create(:menu_item)
          new_menu = FactoryGirl.attributes_for(:menu_item)
          new_menu[:parent_id] = root_item.id
          new_menu[:path] = "some-diff-path"

          post :create, { format: :json, :menu => new_menu }
          JSON.parse(response.body).tap do |menu|
            expect(menu["parent_id"]).to eq(root_item.id)
            expect(menu["depth"]).to eq(1)
            expect(menu["href"]).to eq("/#{root_item.page.path}/some-diff-path")
          end
        end

        it "creates a menu with full content based on tree hierarchy" do
          menu_item
          menu_item.update_path
          parent = menu_item.children.first
          parent.update_path
          new_menu = FactoryGirl.attributes_for(:menu_item)
          new_menu[:parent_id] = parent.id
          new_menu[:path] = "some-fancy-diff-path"

          post :create, { format: :json, :menu => new_menu }
          JSON.parse(response.body).tap do |menu|
            expect(menu["parent_id"]).to eq(parent.id)
            expect(menu["depth"]).to eq(2)
            expect(menu["href"]).to eq("#{parent.page_path}/some-fancy-diff-path")
          end
        end

        it "create a menu without content if url is specifed" do
          new_menu = FactoryGirl.attributes_for(:menu_item)
          new_menu['url'] = "http://www.google.com"
          post :create, { format: :json, :menu => new_menu }
          JSON.parse(response.body).tap do |menu|
            expect(menu["href"]).to eq(new_menu['url'])
          end
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved menu as @menu" do
          menu = FactoryGirl.attributes_for(:menu_item)
          menu.delete(:name)
          expect {
            post :create, { format: :json, :menu => menu }
          }.to_not change(Menu, :count)
          JSON.parse(response.body).tap do |menu|
            expect(menu["errors"]).to_not be_empty
          end
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested menu" do
          menu_item
          put :update, {format: :json, :id => menu_item.to_param, :menu => { name: "Boo"} }
          JSON.parse(response.body).tap do |menu|
            expect(menu["name"]).to eq("Boo")
          end
        end

        it "Move to child of another menu" do
          menu_item
          root_menu = FactoryGirl.create :menu_item
          put :update, {format: :json, :id => menu_item.to_param, :menu => { parent_id: root_menu.id } }
          JSON.parse(response.body).tap do |menu|
            expect(menu["parent_id"]).to eq(root_menu.id)
          end
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested menu" do
        menu_item # Menu with 1 children
        expect {
          delete :destroy, {format: :json, :id => menu_item.to_param}
        }.to change(Menu, :count).by(-2)
      end
    end

  end
end
