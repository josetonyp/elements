require 'rails_helper'
module Elements
  RSpec.describe GalleriesController, type: :controller do
    routes { Elements::Engine.routes }

    let(:picture) { FactoryGirl.create(:picture)  }
    let(:gallery) { FactoryGirl.create(:gallery)  }

    describe "#attachments" do
      it "list all attachments for given content" do
        gallery.attachments << picture
        gallery.save
        get :attachments, { format: :json, id: gallery.to_param }
        JSON.parse(response.body).tap do |attachments|
          expect(attachments.count).to eq(1)
          expect(attachments.first['content']).to eq(gallery.id)
        end
      end
    end

    describe "#add_attachment" do
      it "adds an existing attachment" do
        picture && gallery
        put :add_attachment, { format: :json, id: gallery.to_param, attachment_id: picture}
        gallery.reload
        expect(gallery.attachments.count).to eq(1)
        expect(gallery.attachments.first.id).to eq(picture.id)
        JSON.parse(response.body).tap do |attachments|
          expect(attachments.count).to eq(1)
        end
      end
    end

    describe "#remove_attachment" do
      it "removes an existing attachment" do
        gallery.attachments << picture
        gallery.save
        put :remove_attachment, { format: :json, id: gallery.to_param, attachment_id: picture}
        gallery.reload
        expect(gallery.attachments.count).to eq(0)
        JSON.parse(response.body).tap do |attachments|
          expect(attachments.count).to eq(0)
        end
      end
    end
  end
end
