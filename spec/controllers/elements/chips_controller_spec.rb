require 'rails_helper'
module Elements
  RSpec.describe ChipsController, type: :controller do
    routes { Elements::Engine.routes }

    let(:chip) { FactoryGirl.create(:chip) }

    describe "GET #index" do
      it "assigns all chips as @chips" do
        chip
        get :index, { format: :json }
        JSON.parse(response.body).tap do |chips|
          expect(chips.count).to eq(1)
          expect(chips.last['key']).to eq( chip.key )
          expect(chips.last['key']).to eq( chip.path )
        end
      end
    end

    describe "GET #show" do
      it "assigns the requested chip as @chip" do
        chip
        get :show, {format: :json, :id => chip.to_param}
        JSON.parse(response.body).tap do |json_chip|
          expect(json_chip['id']).to eq(chip.id)
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Chip" do
          expect {
            post :create, { format: :json, :chip => FactoryGirl.attributes_for(:chip) }
          }.to change(Chip, :count).by(1)
        end

        it "adds a children with the correct path" do
          chip = FactoryGirl.create(:chip, key: "first")
          sub_chip = FactoryGirl.attributes_for(:chip, key: "second")
          sub_chip[:parent_id] = chip.id

          post :create, { format: :json, :chip => sub_chip}
          JSON.parse(response.body).tap do |json_chip|
            expect(json_chip['path']).to eq("first.second")
          end
        end
      end

      context "with invalid params" do
        it "doesn't save without valid params" do
          expect {
            post :create, { format: :json, :chip => FactoryGirl.attributes_for(:chip, key: "") }
          }.to_not change(Chip, :count)
          expect {
            post :create, { format: :json, :chip => FactoryGirl.attributes_for(:chip, key: "Wrong Key") }
          }.to_not change(Chip, :count)
          JSON.parse(response.body).tap do |json_chip|
            expect(json_chip["errors"]).to_not be_empty
          end
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested chip" do
          chip
          second = FactoryGirl.create(:chip)
          put :update, { format: :json, :id => chip.to_param, :chip => { parent_id: second.id } }
          JSON.parse(response.body).tap do |json_chip|
            expect(json_chip['parent_id']).to eq(second.id)
          end
        end
      end

      context "with invalid params" do
        it "doesn't change the key but the value" do
          chip
          put :update, { format: :json, :id => chip.to_param, :chip => { key: "newkey", value: "buu"}}
          JSON.parse(response.body).tap do |json_chip|
            expect(json_chip['key']).to_not eq("newkey")
            expect(json_chip['value']).to eq("buu")
          end
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested chip" do
        chip
        expect {
          delete :destroy, { format: :json, :id => chip.to_param}
        }.to change(Chip, :count).by(-1)
      end
    end

  end
end
