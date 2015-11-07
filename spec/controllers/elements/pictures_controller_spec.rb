require 'rails_helper'
module Elements
  RSpec.describe PicturesController, type: :controller do
    routes { Elements::Engine.routes }

    let(:picture) { FactoryGirl.create(:picture) }

    describe "GET #index" do
      it "returns all pictures" do
        picture
        get :index, { format:  :json }
        JSON.parse(response.body).tap do |pictures|
          expect(pictures.count).to eq(1)
          expect(pictures.last['id']).to eq( picture.id )
        end
      end
    end

    describe "GET #show" do
      it "returns a given picture" do
        picture
        get :show, { format: :json, :id => picture.to_param}
        JSON.parse(response.body).tap do |json_picture|
          expect(json_picture["id"]).to eq( picture.id )
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Picture" do
          attachment = FactoryGirl.attributes_for(:picture)
          expect {
            post :create, { format: :json, :attachment => attachment}
          }.to change(Picture, :count).by(1)
        end
      end
    end
  end
end
