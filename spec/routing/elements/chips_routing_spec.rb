require "rails_helper"

module Elements
  RSpec.describe ChipsController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/chips").to route_to("chips#index")
      end

      it "routes to #new" do
        expect(:get => "/chips/new").to route_to("chips#new")
      end

      it "routes to #show" do
        expect(:get => "/chips/1").to route_to("chips#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/chips/1/edit").to route_to("chips#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/chips").to route_to("chips#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/chips/1").to route_to("chips#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/chips/1").to route_to("chips#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/chips/1").to route_to("chips#destroy", :id => "1")
      end

    end
  end
end
