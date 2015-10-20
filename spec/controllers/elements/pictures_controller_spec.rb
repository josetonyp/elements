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
  end
end
