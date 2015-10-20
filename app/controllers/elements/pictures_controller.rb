require_dependency "elements/application_controller"

module Elements
  class PicturesController < ApplicationController
    include Elements::Concerns::PictureActions
  end
end
