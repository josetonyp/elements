require_dependency "elements/application_controller"

module Elements
  class GalleriesController < ApplicationController
    include Elements::Concerns::ContentActions

    def content_class
      Elements::Gallery
    end
  end
end
