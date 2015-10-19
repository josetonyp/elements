require_dependency "elements/application_controller"

module Elements
  class MenusController < ApplicationController
    include Elements::Concerns::MenuActions

  end
end
