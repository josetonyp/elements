require 'rails_helper'
module Elements
  RSpec.describe CommentsController, type: :controller do
    routes { Elements::Engine.routes }

    let!(:content) { FactoryGirl.create :published_content }
    let(:comment) { FactoryGirl.create :published_comment, content: content }
    let(:comment2) { FactoryGirl.create :published_comment, content: content }
    let(:upublished_comment2) { FactoryGirl.create :comment, content: content }

    describe "GET #index" do

      before do
        comment &&
        comment2 &&
        upublished_comment2
      end

      it "returns a list of published comments for given content" do
        get :index, { format: :json, content_id: content.to_param, filter: 'published' }
        JSON.parse(response.body).tap do |comments|
          expect(comments.count).to eq(2)
        end
      end

      it "returns a list of all comments" do
        get :index, { format: :json, content_id: content.to_param }
        JSON.parse(response.body).tap do |comments|
          expect(comments.count).to eq(3)
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

    describe "POST #create" do
      it "publishs a comment" do
        upublished_comment2
        put :publish, { format: :json, content_id: content.to_param, id: upublished_comment2.to_param}
        expect(upublished_comment2.reload).to be_published
      end
    end
  end
end
