require_dependency "elements/application_controller"

module Elements
  class ContentsController < ApplicationController
    include Elements::Concerns::ContentActions

  end
end
