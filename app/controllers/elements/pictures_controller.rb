require_dependency "elements/application_controller"

module Elements
  class PicturesController < ApplicationController
    include Elements::Concerns::AttachmentActions

    def content_class
      Elements::Picture
    end
  end
end
