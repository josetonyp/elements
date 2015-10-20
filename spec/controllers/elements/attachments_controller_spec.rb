require 'rails_helper'
module Elements
  RSpec.describe AttachmentsController, type: :controller do
    routes { Elements::Engine.routes }

    let(:attachment) { FactoryGirl.create(:attachment) }

    describe "GET #index" do
      it "assigns all attachments as @attachments" do
        attachment
        get :index, { format:  :json }
        JSON.parse(response.body).tap do |attachments|
          expect(attachments.count).to eq(1)
          expect(attachments.last['id']).to eq( attachment.id )
        end
      end
    end

    describe "GET #show" do
      it "assigns the requested attachment as @attachment" do
        get :show, { format: :json, :id => attachment.to_param}
        JSON.parse(response.body).tap do |json_attachment|
          expect(json_attachment["id"]).to eq( attachment.id )
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Attachment" do
          attachment = FactoryGirl.attributes_for(:attachment)
          expect {
            post :create, { format: :json, :attachment => attachment}
          }.to change(Attachment, :count).by(1)
        end
      end

      context "with invalid params" do
        it "returns errors when there is no file present" do
          attachment = FactoryGirl.attributes_for(:attachment)
          attachment.delete(:file)
          expect {
            post :create, { format: :json, :attachment => attachment}
          }.to_not change(Attachment, :count)
          JSON.parse(response.body).tap do |json_attachment|
            expect(json_attachment["errors"]).to_not be_empty
          end
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested attachment" do
          put :update, { format: :json, :id => attachment.to_param, :attachment => {title: 'buu'}}
          JSON.parse(response.body).tap do |json_attachment|
            expect(json_attachment["title"]).to eq('buu')
          end
        end
      end

      context "with invalid params" do
        #TODO Find cases where update is not valid
        xit "assigns the attachment as @attachment" do
          put :update, { format: :json, :id => attachment.to_param, :attachment => {file: ""}}
          JSON.parse(response.body).tap do |json_attachment|
            expect(json_attachment["errors"]).to_not be_empty
          end
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested attachment" do
        attachment
        expect {
          delete :destroy, { format: :json, :id => attachment.to_param}
        }.to change(Attachment, :count).by(-1)
      end
    end

  end
end
