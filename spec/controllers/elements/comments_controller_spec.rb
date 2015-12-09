require 'rails_helper'
module Elements
  RSpec.describe CommentsController, type: :controller do
    routes { Elements::Engine.routes }

    let!(:content) { FactoryGirl.create :published_content }
    let(:comment) { FactoryGirl.create :published_comment, content: content }
    let(:comment2) { FactoryGirl.create :published_comment, content: content }
    let(:upublished_comment2) { FactoryGirl.create :comment, content: content }

    describe "GET #index" do
      it "returns a list of published comments for given content" do
        comment &&
        comment2 &&
        upublished_comment2
        get :index, { format: :json, content_id: content.to_param }
        JSON.parse(response.body).tap do |comments|
          expect(comments.count).to eq(2)
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a comment for a given content" do
          expect {
            post :create, { format: :json, content_id: content.to_param, :comment => { text: "Hi there"} }
          }.to change(content.comments, :count).by(1)
        end

        it "creates a comment as child of another comment" do
          comment
          expect {
            post :create, { format: :json, content_id: content.to_param, :comment => { text: "Hi there", parent_id: comment.id } }
          }.to change(content.comments, :count).by(1)

          expect(content.comments.count).to eq(2)
          expect(content.comments.first.children.count).to eq(1)
        end
      end

      context "with invalid params" do
        it "fails to create a comment for a given content" do
          expect {
            post :create, { format: :json, content_id: content.to_param, :comment => { text: ""} }
          }.to_not change(content.comments, :count)
        end
      end
    end
  end
end
