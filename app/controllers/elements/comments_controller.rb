require_dependency "elements/application_controller"

module Elements
  class CommentsController < ApplicationController
    include Elements::Concerns::CommentsActions

  end
end
