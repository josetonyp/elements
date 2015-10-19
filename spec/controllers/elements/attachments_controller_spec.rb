require 'rails_helper'
module Elements
  RSpec.describe AttachmentsController, type: :controller do
    routes { Elements::Engine.routes }

    describe "GET #index" do
      it "assigns all attachments as @attachments" do
        attachment = Attachment.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:attachments)).to eq([attachment])
      end
    end

    describe "GET #show" do
      it "assigns the requested attachment as @attachment" do
        attachment = Attachment.create! valid_attributes
        get :show, {:id => attachment.to_param}, valid_session
        expect(assigns(:attachment)).to eq(attachment)
      end
    end

    describe "GET #new" do
      it "assigns a new attachment as @attachment" do
        get :new, {}, valid_session
        expect(assigns(:attachment)).to be_a_new(Attachment)
      end
    end

    describe "GET #edit" do
      it "assigns the requested attachment as @attachment" do
        attachment = Attachment.create! valid_attributes
        get :edit, {:id => attachment.to_param}, valid_session
        expect(assigns(:attachment)).to eq(attachment)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Attachment" do
          expect {
            post :create, {:attachment => valid_attributes}, valid_session
          }.to change(Attachment, :count).by(1)
        end

        it "assigns a newly created attachment as @attachment" do
          post :create, {:attachment => valid_attributes}, valid_session
          expect(assigns(:attachment)).to be_a(Attachment)
          expect(assigns(:attachment)).to be_persisted
        end

        it "redirects to the created attachment" do
          post :create, {:attachment => valid_attributes}, valid_session
          expect(response).to redirect_to(Attachment.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved attachment as @attachment" do
          post :create, {:attachment => invalid_attributes}, valid_session
          expect(assigns(:attachment)).to be_a_new(Attachment)
        end

        it "re-renders the 'new' template" do
          post :create, {:attachment => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested attachment" do
          attachment = Attachment.create! valid_attributes
          put :update, {:id => attachment.to_param, :attachment => new_attributes}, valid_session
          attachment.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested attachment as @attachment" do
          attachment = Attachment.create! valid_attributes
          put :update, {:id => attachment.to_param, :attachment => valid_attributes}, valid_session
          expect(assigns(:attachment)).to eq(attachment)
        end

        it "redirects to the attachment" do
          attachment = Attachment.create! valid_attributes
          put :update, {:id => attachment.to_param, :attachment => valid_attributes}, valid_session
          expect(response).to redirect_to(attachment)
        end
      end

      context "with invalid params" do
        it "assigns the attachment as @attachment" do
          attachment = Attachment.create! valid_attributes
          put :update, {:id => attachment.to_param, :attachment => invalid_attributes}, valid_session
          expect(assigns(:attachment)).to eq(attachment)
        end

        it "re-renders the 'edit' template" do
          attachment = Attachment.create! valid_attributes
          put :update, {:id => attachment.to_param, :attachment => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested attachment" do
        attachment = Attachment.create! valid_attributes
        expect {
          delete :destroy, {:id => attachment.to_param}, valid_session
        }.to change(Attachment, :count).by(-1)
      end

      it "redirects to the attachments list" do
        attachment = Attachment.create! valid_attributes
        delete :destroy, {:id => attachment.to_param}, valid_session
        expect(response).to redirect_to(attachments_url)
      end
    end

  end
end
