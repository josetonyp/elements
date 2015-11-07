require 'rails_helper'
module Elements
  RSpec.describe PagesController, type: :controller do
    routes { Elements::Engine.routes }

    let(:content) { FactoryGirl.create :content }
    let(:page) { FactoryGirl.create :page }
    let(:published_content) { FactoryGirl.create :published_content }
    let(:published_page) { FactoryGirl.create :published_page }

    describe "GET #index" do
      it "assigns all pages as @pages" do
        published_content && page && published_page
        get :index, { format: :json }
        JSON.parse(response.body).tap do |pages|
          expect(pages.count).to eq(1)
          expect(pages.first['id']).to eq(published_page.id)
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Page" do
          expect {
            post :create, { format: :json, :content => FactoryGirl.attributes_for(:page) }
          }.to change(Page, :count).by(1)
        end
      end
    end
  end
end
