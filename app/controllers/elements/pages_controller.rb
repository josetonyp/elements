require_dependency "elements/application_controller"

module Elements
  class PagesController < ApplicationController
    include Elements::Concerns::PageActions

  end
end
