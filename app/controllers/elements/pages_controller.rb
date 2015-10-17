require_dependency "elements/application_controller"

module Elements
  class PagesController < ApplicationController
    include Elements::Concerns::ContentActions

    def content_class
      Page
    end

  end
end
