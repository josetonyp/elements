require_dependency "elements/application_controller"

module Elements
  class GalleriesController < ApplicationController
    include Elements::Concerns::GalleryActions

  end
end
