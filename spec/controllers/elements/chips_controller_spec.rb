require 'rails_helper'
module Elements
  RSpec.describe ChipsController, type: :controller do
    routes { Elements::Engine.routes }

    let(:chip) { FactoryGirl.create :chip }

    describe "GET #index" do
      it "assigns all chips as @chips" do
        get :index, {}, valid_session
        expect(assigns(:chips)).to eq([chip])
      end
    end

    describe "GET #show" do
      it "assigns the requested chip as @chip" do
        chip = Chip.create! valid_attributes
        get :show, {:id => chip.to_param}, valid_session
        expect(assigns(:chip)).to eq(chip)
      end
    end

    describe "GET #new" do
      it "assigns a new chip as @chip" do
        get :new, {}, valid_session
        expect(assigns(:chip)).to be_a_new(Chip)
      end
    end

    describe "GET #edit" do
      it "assigns the requested chip as @chip" do
        chip = Chip.create! valid_attributes
        get :edit, {:id => chip.to_param}, valid_session
        expect(assigns(:chip)).to eq(chip)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Chip" do
          expect {
            post :create, {:chip => valid_attributes}, valid_session
          }.to change(Chip, :count).by(1)
        end

        it "assigns a newly created chip as @chip" do
          post :create, {:chip => valid_attributes}, valid_session
          expect(assigns(:chip)).to be_a(Chip)
          expect(assigns(:chip)).to be_persisted
        end

        it "redirects to the created chip" do
          post :create, {:chip => valid_attributes}, valid_session
          expect(response).to redirect_to(Chip.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved chip as @chip" do
          post :create, {:chip => invalid_attributes}, valid_session
          expect(assigns(:chip)).to be_a_new(Chip)
        end

        it "re-renders the 'new' template" do
          post :create, {:chip => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested chip" do
          chip = Chip.create! valid_attributes
          put :update, {:id => chip.to_param, :chip => new_attributes}, valid_session
          chip.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested chip as @chip" do
          chip = Chip.create! valid_attributes
          put :update, {:id => chip.to_param, :chip => valid_attributes}, valid_session
          expect(assigns(:chip)).to eq(chip)
        end

        it "redirects to the chip" do
          chip = Chip.create! valid_attributes
          put :update, {:id => chip.to_param, :chip => valid_attributes}, valid_session
          expect(response).to redirect_to(chip)
        end
      end

      context "with invalid params" do
        it "assigns the chip as @chip" do
          chip = Chip.create! valid_attributes
          put :update, {:id => chip.to_param, :chip => invalid_attributes}, valid_session
          expect(assigns(:chip)).to eq(chip)
        end

        it "re-renders the 'edit' template" do
          chip = Chip.create! valid_attributes
          put :update, {:id => chip.to_param, :chip => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested chip" do
        chip = Chip.create! valid_attributes
        expect {
          delete :destroy, {:id => chip.to_param}, valid_session
        }.to change(Chip, :count).by(-1)
      end

      it "redirects to the chips list" do
        chip = Chip.create! valid_attributes
        delete :destroy, {:id => chip.to_param}, valid_session
        expect(response).to redirect_to(chips_url)
      end
    end

  end
end
