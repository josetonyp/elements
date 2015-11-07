require 'rails_helper'
module Elements
  RSpec.describe ContentsController, type: :controller do
    routes { Elements::Engine.routes }

    let(:content) { FactoryGirl.create :content }
    let(:published_content) { FactoryGirl.create :published_content }
    let(:future_content) { FactoryGirl.create :future_content }

    describe "GET #index" do
      it "assigns all contents as @contents" do
        content && published_content && future_content
        get :index, { format: :json }
        JSON.parse(response.body).tap do |contents|
          expect(contents.count).to eq(1)
          expect(contents.first['id']).to eq(published_content.id)
        end
      end
    end

    describe "GET #show" do
      it "assigns the requested content as @content" do
        published_content
        get :show, {:id => published_content.to_param, format: :json}
        expect(assigns(:content)).to eq(published_content)
      end

      it "doesn't show unpublished content" do
        future_content
        expect{
          get :show, {:id => future_content.to_param, format: :json}
        }.to raise_error ActiveRecord::RecordNotFound
      end

      it "doesn't show unpublished content" do
        content
        expect{
          get :show, {:id => content.to_param, format: :json}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Content" do
          expect {
            post :create, { format: :json, :content => FactoryGirl.attributes_for(:content) }
          }.to change(Content, :count).by(1)
        end

        it "assigns a newly created content as @content" do
          post :create, {format: :json, :content => FactoryGirl.attributes_for(:content)}
          expect(assigns(:content)).to be_a(Content)
          expect(assigns(:content)).to be_persisted
        end
      end

      context "with invalid params" do
        it "doesn't create new content without name and value" do
          content = FactoryGirl.attributes_for(:content)
          content.delete(:name) && content.delete(:value)
          expect {
            post :create, { format: :json, :content => content }
          }.not_to change(Content, :count)
          expect(JSON.parse(response.body)["errors"]).to_not be_empty
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested content" do
          put :update, {format: :json, :id => content.to_param, :content => { name: "Boo"} }
          content.reload
          expect(content.name).to eq("Boo")
          expect(content.versions.count).to eq(2)
          expect(content.previous_version.name).to_not eq(content.name)
        end

        it "assigns the requested content as @content" do
          put :update, {format: :json, :id => content.to_param, :content => { name: "Boo"}}
          expect(assigns(:content)).to eq(content)
        end
      end

      context "with invalid params" do
        it "assigns the content as @content" do
          put :update, {format: :json, :id => content.to_param, :content =>  { name: ""} }
          expect(assigns(:content)).to eq(content)
          expect(JSON.parse(response.body)["errors"]).to_not be_empty
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested content" do
        content
        expect {
          delete :destroy, {format: :json, :id => content.to_param}
        }.to change(Content, :count).by(-1)
      end
    end

    describe "GET #versions" do
      it "returns all versions of given content" do
        new_content = nil
        Timecop.freeze(Date.today - 30) do
          new_content = Content.create(FactoryGirl.attributes_for(:content))
          new_content.save
          new_content.reload
        end
        Timecop.return
        name = new_content.name
        sleep 0.5
        Timecop.freeze(Date.today - 10) do
          new_content.name = "Some new name"
          new_content.save
          new_content.reload
        end
        Timecop.return
        sleep 0.5
        Timecop.freeze(Date.today - 5) do
          new_content.name = "Some other new name"
          new_content.save
          new_content.reload
        end
        Timecop.return
        sleep 0.5
        new_content.reload
        get :versions, { format: :json, id: new_content.to_param }
        JSON.parse(response.body).tap do |versions|
          expect(versions.count).to eq(3)
          expect(versions.first['content']['name']).to eq("Some other new name")
          expect(versions.last['content']['name']).to eq(name)
        end
      end
    end

    describe "PUT #revert" do
      it "revert given content to previous_version" do
        new_content = nil
        Timecop.freeze(Date.today - 30) do
          new_content = Content.create(FactoryGirl.attributes_for(:content))
          new_content.save
          new_content.reload
        end
        name = new_content.name
        new_content.name = "Oberholz test"
        new_content.save
        new_content.reload
        put :revert, { format: :json, id: new_content.to_param }
        JSON.parse(response.body).tap do |content|
          expect(content['name']).to eq(name)
          expect(content['versions']).to eq(3)
        end
      end
    end

    describe "GET #field_versions" do
      it "returns all versions of given field" do
        new_content = nil
        Timecop.freeze(Date.today - 30) do
          new_content = Content.create(FactoryGirl.attributes_for(:content))
          new_content.save
          new_content.reload
        end
        name = new_content.name
        new_content.name = "Oberholz test"
        new_content.save
        new_content.reload
        get :field_versions, { format: :json, id: new_content.to_param, field: "name"}
        JSON.parse(response.body).tap do |versions|
          expect(versions.count).to eq(2)
          expect(versions.last['name']).to eq(name)
        end
      end
    end

  end
end
